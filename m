Received:  by oss.sgi.com id <S553954AbRCIC2x>;
	Thu, 8 Mar 2001 18:28:53 -0800
Received: from ns5.Sony.CO.JP ([202.238.80.5]:61700 "EHLO ns5.sony.co.jp")
	by oss.sgi.com with ESMTP id <S553764AbRCIC2m>;
	Thu, 8 Mar 2001 18:28:42 -0800
Received: from mail2.sony.co.jp (gatekeeper8.Sony.CO.JP [202.238.80.22])
	by ns5.sony.co.jp (R8) with ESMTP id f292Se354688;
	Fri, 9 Mar 2001 11:28:40 +0900 (JST)
Received: from mail2.sony.co.jp (localhost [127.0.0.1])
	by mail2.sony.co.jp (R8) with ESMTP id f292SeY15344;
	Fri, 9 Mar 2001 11:28:40 +0900 (JST)
Received: from smail1.sm.sony.co.jp (smail1.sm.sony.co.jp [43.11.253.1])
	by mail2.sony.co.jp (R8) with ESMTP id f292Sev15336;
	Fri, 9 Mar 2001 11:28:40 +0900 (JST)
Received: from imail.sm.sony.co.jp (imail.sm.sony.co.jp [43.27.209.5]) by smail1.sm.sony.co.jp (8.8.8/3.6W) with ESMTP id LAA03188; Fri, 9 Mar 2001 11:28:42 +0900 (JST)
Received: from mach0.sm.sony.co.jp (mach0.sm.sony.co.jp [43.27.210.135]) by imail.sm.sony.co.jp (8.8.8/3.7W) with ESMTP id LAA10517; Fri, 9 Mar 2001 11:28:08 +0900 (JST)
Received: from localhost by mach0.sm.sony.co.jp (8.8.8/FreeBSD) with ESMTP id LAA14074; Fri, 9 Mar 2001 11:28:08 +0900 (JST)
To:     bellard@email.enst.fr
Cc:     linux-mips@oss.sgi.com
Subject: Re: mips gcc 2.95.2 and 2.91.66 bug
In-Reply-To: <Pine.GSO.4.02.10103081721360.9471-100000@donjuan.enst.fr>
References: <3AA7B13F.F918E1F8@ti.com>
	<Pine.GSO.4.02.10103081721360.9471-100000@donjuan.enst.fr>
X-Mailer: Mew version 1.94.1 on Emacs 19.34 / Mule 2.3 (SUETSUMUHANA)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010309112808P.machida@sm.sony.co.jp>
Date:   Fri, 09 Mar 2001 11:28:08 +0900
From:   Hiroyuki Machida <machida@sm.sony.co.jp>
X-Dispatcher: imput version 990905(IM130)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


From: Fabrice Bellard <bellard@email.enst.fr>
Subject: mips gcc 2.95.2 and 2.91.66 bug
Date: Thu, 8 Mar 2001 17:43:31 +0100 (MET)

> Hi!
> 
> Maybe this bug can interest you: when using byte swaping in le16_to_cpu
> for example, mips gcc 2.95.2 and 2.91.66 sometime do not generate correct
> code : the u16 to u32 convertion is missing. I found this bug while
> compiling drivers/mtd/ftl.c in build_maps(). Here is a sample source to
> reproduce the bug:

This bug is fixed by following chage in GCC 3.0. 

gcc/gcc/ChangeLog.3:

2000-04-24  Hiroyuki Machida <machida@sm.sony.co.jp>

        * combine.c (try_combine): Update reg_nonzero_bits of
        newi2pat before newpat.


Please refer mail archives at gcc.gnu.org for details.
You can easily apply this fix to gcc-2.95.x.

---
Hiroyuki Machida
Creative Station		SCE Inc.
