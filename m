Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 30 Sep 2007 11:33:24 +0100 (BST)
Received: from webmail.ict.ac.cn ([159.226.39.7]:40328 "EHLO ict.ac.cn")
	by ftp.linux-mips.org with ESMTP id S20033356AbXI3KdP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 30 Sep 2007 11:33:15 +0100
Received: (qmail 12332 invoked by uid 507); 30 Sep 2007 18:31:16 +0800
Received: from unknown (HELO ?192.168.1.8?) (fxzhang@222.92.8.142)
  by ict.ac.cn with SMTP; 30 Sep 2007 18:31:16 +0800
Message-ID: <46FF7BC2.5050905@ict.ac.cn>
Date:	Sun, 30 Sep 2007 18:34:42 +0800
From:	Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: IceDove 1.5.0.10 (X11/20070329)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: cmpxchg broken in some situation
Content-Type: text/plain; charset=GB18030; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16745
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips

hi,   
   Today I run across a possible bug of cmpxchg implementation. When 
playing with DRM on our Fulong, the following function 
(drivers/char/drm/drm_lock.c) is not working correctly in 64BIT mips:
   cmpxchg failed to set *lock to new value. (return 0 with *lock unchanged)
It is probably due to type conversions between unisigned int and 
unsigned long.  When I change cmpxchg to mycmpxchg(attached below), 
problem disappeared.                                 

int drm_lock_free(struct drm_lock_data *lock_data, unsigned int context)
{
        unsigned int old, new, prev;
        volatile unsigned int *lock = &lock_data->hw_lock->lock;

        spin_lock(&lock_data->spinlock);
        if (lock_data->kernel_waiters != 0) {
                drm_lock_transfer(lock_data, 0);
                lock_data->idle_has_lock = 1;
                spin_unlock(&lock_data->spinlock);
                return 1;
        }
        spin_unlock(&lock_data->spinlock);

        do {
                old = *lock;
                new = _DRM_LOCKING_CONTEXT(old);
                prev = cmpxchg(lock, old, new);
        } while (prev != old);

        if (_DRM_LOCK_IS_HELD(old) && _DRM_LOCKING_CONTEXT(old) != 
context) {
                DRM_ERROR("%d freed heavyweight lock held by %d\n",
                          context, _DRM_LOCKING_CONTEXT(old));
                return 1;
        }
        wake_up_interruptible(&lock_data->lock_queue);
        return 0;
}

static inline unsigned int mycmpxchg(volatile int * m, unsigned int old,
        unsigned int new)  //unsigned long to unsigned int
{
        __u32 retval;

        __asm__ __volatile__(
                        "       .set    
push                                    \n"
                        "       .set    
noat                                    \n"
                        "       .set    
mips3                                   \n"
                        "1:     ll      %0, %2                  # 
__mycmpxchg_u32       \n"
                        "       bne     %0, %z3, 
2f                             \n"
                        "       .set    
mips0                                   \n"
                        "       move    $1, 
%z4                                 \n"
                        "       .set    
mips3                                   \n"
                        "       sc      $1, 
%1                                  \n"
                        "       beqz    $1, 
3f                                  \n"
                        
"2:                                                     \n"
                        "       .subsection 
2                                   \n"
                        "3:     b       
1b                                      \n"
                        "       
.previous                                       \n"
                        "       .set    
pop                                     \n"
                        : "=&r" (retval), "=R" (*m)
                        : "R" (*m), "Jr" (old), "Jr" (new)
                        : "memory");

        smp_llsc_mb();

        return retval;
}
