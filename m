Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Sep 2002 14:34:15 +0200 (CEST)
Received: from webmail22.rediffmail.com ([203.199.83.144]:64464 "HELO
	webmail22.rediffmail.com") by linux-mips.org with SMTP
	id <S1122961AbSIRMeO>; Wed, 18 Sep 2002 14:34:14 +0200
Received: (qmail 28352 invoked by uid 510); 18 Sep 2002 12:31:48 -0000
Date: 18 Sep 2002 12:31:48 -0000
Message-ID: <20020918123148.28350.qmail@webmail22.rediffmail.com>
Received: from unknown (202.54.89.92) by rediffmail.com via HTTP; 18 Sep 2002 12:31:48 -0000
MIME-Version: 1.0
From: "atul srivastava" <atulsrivastava9@rediffmail.com>
Reply-To: "atul srivastava" <atulsrivastava9@rediffmail.com>
To: linux-mips@linux-mips.org
Subject: vm_growsdown in mips..
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Return-Path: <atulsrivastava9@rediffmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 233
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: atulsrivastava9@rediffmail.com
Precedence: bulk
X-list: linux-mips

Hello,

after kernel has booted , when  shell is being
execve'ed it repeatedly loops in do_page_fault()
with address 0x0fc01788.

address 0x0fc01788 is well within user address space.

In do_page_fault() code

1.vma = find_vma(mm,address) goes succefully ..means address 
pertains to the current task.

2.but fails in
       if(!(vma->vm_flags & VM_GROWSDOWN)
          {
            goto bad_area;
          }

VM_GROWSDOWN flag indicates the stack area.

is this indicates problem with mmu initialisation..?

Best Regards,


__________________________________________________________
Give your Company an email address like
ravi @ ravi-exports.com.  Sign up for Rediffmail Pro today!
Know more. http://www.rediffmailpro.com/signup/
