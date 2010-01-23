Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jan 2010 13:02:38 +0100 (CET)
Received: from mail-pz0-f172.google.com ([209.85.222.172]:65509 "EHLO
        mail-pz0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492232Ab0AWMCd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Jan 2010 13:02:33 +0100
Received: by pzk2 with SMTP id 2so1532336pzk.21
        for <multiple recipients>; Sat, 23 Jan 2010 04:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=Bdssmb+AsKKrZ1rv9CoQRmRlv1o3OoxBzH6mH4eRyJ8=;
        b=SlUUb1EdbmbZKIR+5vS7HTcJn5rRXLWSGv9IwM06wqUaVCpAcS76/s0n0pbz4Ci2Pm
         oUtJFP3MbRk1463QSSrmBywNNZz7w1hg7JAeezxU99CLmt8Ug3kcjpB76Zc/us0l1UuC
         DM1c3DOcEC02TJ6Ecl5Pttl3YXCon/8ASFtgI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=nqK9N8ptTwHC3spjaqyBKOyJso8wYMA0S8pKsK3KiuYEEXoYDSaYOtLLRM13VMQ1i1
         VHOkspzG+ZCaktrgqJBIUC46UjQ1lC55hkGVNs5/A+D8WMSPIHh1R1SGlS1nMSLRwuPS
         LJzRsd3h0+WnV0wRoAsEOW4kTYFhYwftP/SnY=
Received: by 10.142.1.35 with SMTP id 35mr2822329wfa.330.1264248144736;
        Sat, 23 Jan 2010 04:02:24 -0800 (PST)
Received: from ?192.168.2.212? ([202.201.14.140])
        by mx.google.com with ESMTPS id 23sm2866779pzk.8.2010.01.23.04.02.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 23 Jan 2010 04:02:24 -0800 (PST)
Subject: Re: [PATCHv2] MIPS: fix vmlinuz build for 32bit-only math shells
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Alexander Clouter <alex@digriz.org.uk>, linux-mips@linux-mips.org
In-Reply-To: <20100122145256.GA5570@linux-mips.org>
References: <vs6k27-7b2.ln1@chipmunk.wormnet.eu>
         <20100122145256.GA5570@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Sat, 23 Jan 2010 19:56:16 +0800
Message-ID: <1264247776.14811.8.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.2 
Content-Transfer-Encoding: 7bit
X-archive-position: 25641
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 15322

On Fri, 2010-01-22 at 15:52 +0100, Ralf Baechle wrote:
> On Wed, Jan 20, 2010 at 08:50:07PM +0000, Alexander Clouter wrote:
> 
> > Counter to the documentation for the dash shell, it seems that on my
> > x86_64 filth under Debian only does 32bit math.  As I have configured my
> 
> POSIX apparently specifies at least "long" type arithmetic for shells, so
> if your dash indeed is a 64-bit binary it's in violation of POSIX.  What
> does
> 
>   file $(which $SHELL)
> 
> say?
> 
> The dash binary on my Fedora 12 i386 seems to perform 64-bit arithmetic.
> 

Hi, Ralf

on my yeeloong laptop, with dash(0.5.5.1-3) in o32 ABI, it also can only
execute 32-bit numbers, but on my thinkpad SL400(i686, dash version is
0.5.5.1-2), it works well with 64-bit arithmetic.

So, it means dash not always works normally, perhaps there is a bug
there, or the bug only exists on MIPS machines?

Best Regards,
	Wu Zhangjin
