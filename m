Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 May 2009 01:17:49 +0100 (BST)
Received: from mail-pz0-f202.google.com ([209.85.222.202]:33129 "EHLO
	mail-pz0-f202.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025212AbZEUARo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 21 May 2009 01:17:44 +0100
Received: by pzk40 with SMTP id 40so675914pzk.22
        for <multiple recipients>; Wed, 20 May 2009 17:17:37 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=lNO/j4iBY9C6yf+4JkrowBHdCR1OlZM/IxTwmolZ5FM=;
        b=lYmbEOhs4oB0T4ION4bDakm5GWwDeovKfv6tZ4C546MGuscp6Z15td2s/ihpXdkBt1
         3j6ePpWYmAF2gqtBdjbGtx/o3n1jY9DPezVxIrko6xZJRecuEejTm7WdMfKbwfVFqL0Q
         dbShLHK9Sw4pvQ/PLNfD46ut86yi7bxbVjGjY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=VE/ubBX1UQB84PuHIjLw3WzdY76niyeWDiNlN6H6THU/i+3XEmGUS4gQhsO9cb/kll
         HLu4s39QLfhAgKa5Byco/TO5dEekUbsSAcBJ3VB3a24bykY3tiORBSHY2PSiOE0CEyjs
         BtgtrT/7AZH2ke3npnMxiz2mya2eYeb+pSEO8=
Received: by 10.114.200.2 with SMTP id x2mr3816573waf.83.1242865055559;
        Wed, 20 May 2009 17:17:35 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id n30sm4170637wag.6.2009.05.20.17.17.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 May 2009 17:17:34 -0700 (PDT)
Subject: Re: [loongson-support 00/27] linux PATCHes of loongson-based
 machines
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Daniel Clark <dclark@pobox.com>
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	Yan hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, gnewsense-dev@nongnu.org,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>, rms@gnu.org
In-Reply-To: <4A14846A.3080006@pobox.com>
References: <cover.1242851584.git.wuzhangjin@gmail.com>
	 <4A14846A.3080006@pobox.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Thu, 21 May 2009 08:17:18 +0800
Message-Id: <1242865038.21692.624.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22900
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, 2009-05-20 at 18:30 -0400, Daniel Clark wrote:
> wuzhangjin@gmail.com wrote:
> > From: Wu Zhangjin <wuzhangjin@gmail.com>
> > 
> > Dear all,
> > 
> > I have cleaned up the source code of loongson-based machines support and
> > updated it to linux-2.6.29.3, the latest result is put to the following git
> > repository:
> > 
> >    git://dev.lemote.com/rt4ls.git  to-ralf
> > 	or
> >    http://dev.lemote.com/cgit/rt4ls.git/log/?h=to-ralf
> > 
> > this job is based on the to-mips branch of Yanhua's
> > git://dev.lemote.com/linux_loongson.git and the lm2e-fixes branch of Philippe's
> > git://git.linux-cisco.org/linux-mips.git. thanks goes to them.
> > 
> > and also, thanks goes to Erwen and heihaier for testing the latest branch, and
> > thanks ralf, zhangLe, john and the other guyes for reviewing the old branch and
> > giving good suggestions.
> > 
> > the most differences between this branch and the old branch include:
> > 
> >    * all of these patches are checked by script/checkpatch.pl, only a few
> >    warnings left.
> > 
> >    * the cs5536 part have been cleaned up deeply. the old pcireg.h is removed
> >    via using the include/linux/pci_regs.h instead. and the old cs5536_vsm.c is
> >    divided to several modules, one file one module.
> > 
> >    * the source code in driver/video/smi in cleaned up a lot, two trashy header
> >    files are removed, and several trashy functions are removed, lots of coding
> >    style errors and warnings are cleaned up.
> > 
> >    * gcc 4.4 support, including 32bit and 64bit, and also it is gcc 4.3
> >    compatiable
> > 
> > I have tested it in 32bit and 64bit with gcc 4.3 on fuloong(2e), fuloong(2f),
> > yeeloong(2f), all of them work well, and also test it in 32bit and 64bit with
> > gcc 4.4 on fuloong(2f), works normally. Erwen and heihaier have tested it in
> > 64bit with gcc 4.4 on a yeeloong laptop.
> 
> Wow this is great. Does this branch also include the suspend-to-disk /
> resume-from-disk code from the lemote 2.6.27 STD branch?
> 

yeap, you can find it in the PATCH: 
                                    
[loongson-PATCH-v1 22/27]
Hibernation Support in mips system

> From a user's perspective, what are the loongson-oriented improvements
> of this branch over the existing 2.6.27 branch?
> 

seems no obvious improvements to users, but a few:

   * smaller kernel image,
      
     several different changes will influence this part.

    1. [loongson-PATCH-v1 10/27] add loongson-specific
cpu-feature-overrides.h

     $ wc -c vmlinux             // before
    8054849 vmlinux
    $ wc -c vmlinux             // after
    7626936 vmlinux
    $ echo $(((8054849-7626936)/1024))  // kb
    417
    $ echo "(8054849-7626936)/8054849" | bc -l
    .05312489408553779220
     
    2. tons of source code lines have been cleaned up
     
    the most important parts include cs5536 and smi video card driver.

  * higher performance(maybe not easily feel it)
   
    1. the added cpu-feature-overrides will remove tons of branches
    2. tons of low-level cs5536 support is cleaned up, some trashy
source code lines are removed, so, the low-level response may be
quicker.

   but i think the change in this branch is more important to the
developers, the current organization is more scalable than the old one,
and tons of duplications have bee removed, magic numbers have been
substituted to understandable symbols ...

> I'd also like to know if:
> 
> (a) the ec-modules and
> 
> (b) the rtl8187b code
> 
> that is currently separate from the main lemote linux 2.6.27 git (the
> former in a git repository, the later only in a .tar.gz file as far as I
> know) is included in the 2.6.29.3 branch now.
> 

not yet, since the main aim of this branch is pushing the basic
loongson2f-based machines' support to the mainline linux. so, these two
parts are not included in yet. after the basic support is pushed in, we
will try to push the other parts.

> I can of course check this via git when I have internet access next, but
> I'm guessing you would be able to provide context beyond just the code
> changes to the answers of these questions  :-)
> 
> Oh, and one last thing - is compilation with the lemote-patched binutils
> / "-mfix-gs2f-kernel" "-mfix-ls2f-kernel" (I'm told these did the same
> things, the name just changed for some reason - currently I'm using a
> binutils / as that understands the "-mfix-ls2f-kernel" option) still
> needed? Without this in the 2.6.27 branch, and esp. with the ec-modules,
> there were very frequent hard linux crashes (sysrq keys not working).
> 

yes, the -mfix-ls2f-kernel is needed if no other solutions for fixing
the crashes problems come out. but since the -mfix-ls2f-kernel option is
not merged in the mainline 'as' tool, so, this option will not be used
in this branch. 

sysrq keys really not work, but NMI works :-)

> BTW for me, this is interesting in the context of
> http://config.fsf.org/trac/public/wiki/RmsLinuxForYou , which I have
> several people helping me test at the moment - currently the biggest
> issue is hard crashes every day or other day, or more frequently if
> there is a lot of disk or usb I/O.
> 

perhaps Yan hua<yanh@lemote.com> can give some help on this problem.

did you compile the kernel with -mfix-ls2f-kernel option? if not, please
use it. it may give some help on reducing the hard crashes.

Best Wishes,
Wu Zhangjin

> Thanks,
