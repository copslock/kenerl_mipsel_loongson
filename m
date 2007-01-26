Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Jan 2007 16:59:06 +0000 (GMT)
Received: from tomts43.bellnexxia.net ([209.226.175.110]:56251 "EHLO
	tomts43-srv.bellnexxia.net") by ftp.linux-mips.org with ESMTP
	id S20053486AbXAZQ7B (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 26 Jan 2007 16:59:01 +0000
Received: from krystal.dyndns.org ([67.68.204.133])
          by tomts43-srv.bellnexxia.net
          (InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP
          id <20070126165715.IRLO11361.tomts43-srv.bellnexxia.net@krystal.dyndns.org>;
          Fri, 26 Jan 2007 11:57:15 -0500
Received: from localhost (localhost [127.0.0.1])
  (uid 1000)
  by krystal.dyndns.org with local; Fri, 26 Jan 2007 11:57:12 -0500
  id 002F9AEA.45BA32E9.00001042
Date:	Fri, 26 Jan 2007 11:57:12 -0500
From:	Mathieu Desnoyers <compudj@krystal.dyndns.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 05/10] local_t : mips extension
Message-ID: <20070126165712.GA21098@Krystal>
References: <1169741777507-git-send-email-mathieu.desnoyers@polymtl.ca> <1169741780423-git-send-email-mathieu.desnoyers@polymtl.ca> <20070126120437.GA18778@linux-mips.org> <20070126163623.GB26138@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20070126163623.GB26138@Krystal>
X-Editor: vi
X-Info:	http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 11:53:59 up 156 days, 14:01,  5 users,  load average: 5.09, 2.48, 1.53
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <compudj@krystal.dyndns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13821
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: compudj@krystal.dyndns.org
Precedence: bulk
X-list: linux-mips

* Mathieu Desnoyers (mathieu.desnoyers@polymtl.ca) wrote:
> > What I generally dislike about this patch is that several fairly large
> > functions have been duplicated with only little change.
> > 
> 
> Yeah, I know. Until we find some way to share atomic operation code for
> both operation on local and shared data, we have to duplicate this. We
> could think about a header that would support multiple inclusion and
> behave differently (different function prefix and LOCKing/memory
> barriers) depending on defines set by the top level header.
> 
> Something like
> 
> asm/atomic.h
>   #define ATOMIC_SHARED
>   #include <asm/atomic-ops.h>  /* shared */
>   #undef ATOMIC_SHARED
>   #include <asm/atomic-ops.h>  /* local */
> 
> asm/atomic-ops.h 
>   #ifdef ATOMIC_SHARED
>   #define ATOMIC_PREFIX atomic
>   #define ATOMIC_BARRIER() smp_mb()
>   #define ATOMIC_TYPE atomic_t
>   #define ATOMIC_VAR (v->counter)
>   #else
>   #define ATOMIC_PREFIX local
>   #define ATOMIC_BARRIER()
>   #define ATOMIC_TYPE local_t
>   #define ATOMIC_VAR (v->a.counter)
>   #endif
>   
>   static __inline__ ATOMIC_PREFIX##_add_return(int i, ATOMIC_TYPE *v)
>   .....
>   #undef ATOMIC_PREFIX
>   #undef ATOMIC_BARRIER
>   #undef ATOMIC_TYPE
>   #undef ATOMIC_VAR
> 

More prefisely, for this to work, we should change :
#define ATOMIC_PREFIX atomic
and
#define ATOMIC_PREFIX local
for

#define ATOMICF(fctname) atomic_##fctname
and
#define ATOMICF(fctname) local_##fctname


which would make de declaration look like :

static __inline__ ATOMICF(add_return)(int i, ATOMIC_TYPE *v)

Which starts to look a little odd to me, doesn't it ?

Regards,

Mathieu

-- 
OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
