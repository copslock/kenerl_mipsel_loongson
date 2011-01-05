Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Jan 2011 14:00:25 +0100 (CET)
Received: from mail-qw0-f49.google.com ([209.85.216.49]:35168 "EHLO
        mail-qw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490978Ab1AENAW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Jan 2011 14:00:22 +0100
Received: by qwj9 with SMTP id 9so15536937qwj.36
        for <linux-mips@linux-mips.org>; Wed, 05 Jan 2011 05:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=BQFz5QfUbxZWrTtjsTaa8tDSJIQYFFJEB0P64Idydq0=;
        b=dxM0e/SD2Vz030ihfK3hD9mCZw/YhgAo+MP13WWVKIW7aSCrJoXcr+7iL/jcWDDfbU
         bt1FOMOyCCj46CEuDi1O5g7gubJof7pvah+9M0ckJYhpZHEZna9MLITktrKY9Wzbpqxa
         SEP+iQ4EUy5LseFg8sZQXSoOpA1MbvZvkxLtk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=YTv5SHgfmTphIdlATbQWibw3iDqAiAPIOm/CsHzbQBmbzNDzjqi5ulImjR7mSroQn7
         ebqeCkkytPMpgqkpWEAvhl74IQSrQaRrATzyyJGUSfkMoFL+BVCulHkFO2pZkukhMDF0
         Yzc73dO6FODvEbpaMtU7Wd1dPfaUJbf17tRtU=
Received: by 10.229.75.9 with SMTP id w9mr19952980qcj.108.1294232414468;
        Wed, 05 Jan 2011 05:00:14 -0800 (PST)
Received: from [172.16.48.51] ([59.160.135.215])
        by mx.google.com with ESMTPS id q12sm13542015qcu.6.2011.01.05.05.00.11
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 05 Jan 2011 05:00:13 -0800 (PST)
Subject: Re: SMTC support status in latest git head.
From:   Anoop P A <anoop.pa@gmail.com>
To:     "Kevin D. Kissell" <kevink@paralogos.com>
Cc:     STUART VENTERS <stuart.venters@adtran.com>,
        "Anoop P.A." <Anoop_P.A@pmc-sierra.com>, linux-mips@linux-mips.org
In-Reply-To: <4D2367EE.7000702@paralogos.com>
References: <8F242B230AD6474C8E7815DE0B4982D7179FB88F@EXV1.corp.adtran.com>
         <1293470392.27661.202.camel@paanoop1-desktop>
         <1293524389.27661.210.camel@paanoop1-desktop>
         <4D19A31E.1090905@paralogos.com>
         <1293798476.27661.279.camel@paanoop1-desktop>
         <4D1EE913.1070203@paralogos.com>
         <1294067561.27661.293.camel@paanoop1-desktop>
         <4D21F5D3.50604@paralogos.com>
         <1294082426.27661.330.camel@paanoop1-desktop>
         <4D22D7B3.2050609@paralogos.com>
         <1294146165.27661.361.camel@paanoop1-desktop>
         <1294151822.27661.375.camel@paanoop1-desktop>
         <4D235717.1000603@paralogos.com>
         <1294163657.27661.386.camel@paanoop1-desktop>
         <4D2367EE.7000702@paralogos.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 05 Jan 2011 18:41:37 +0530
Message-ID: <1294233097.27661.391.camel@paanoop1-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <anoop.pa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28842
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anoop.pa@gmail.com
Precedence: bulk
X-list: linux-mips

On Tue, 2011-01-04 at 10:33 -0800, Kevin D. Kissell wrote:
> On 01/04/11 09:54, Anoop P A wrote:
> > On Tue, 2011-01-04 at 09:21 -0800, Kevin D. Kissell wrote:
> >> I'm trying to figure out a reason why your change below should help, and
> >> offhand, modulo tool bugs, I don't see it.  I'm assuming that your diff
> >> below is a diff relative to the pre-patch stackframe.h.   I wouldn't
> > Yes patch created against stock code .
> >
> >> bless it as an alternative because it moves code and comments
> >> unnecessarily - all you should really have to do is to move the
> >>
> >>
> >>    190                 mfc0    v1, CP0_STATUS
> >>    191                 LONG_S  $2, PT_R2(sp)
> >>
> >> to be just after the #endif /* CONFIG_MIPS_MT_SMTC */ at around line 201.
> > Actually I just moved code under CONFIG_MIPS_MT_SMTC to previous block
> > of code ( which store $0 ) . git diff did the rest on behalf of me :)
> >
> >> If moving the save of zero to PT_R0(sp) actually makes a difference,
> >> it's evidence that you've got problems in your toolchain (or, heaven
> >> forbid, your pipeline)!
> > In previous version of patch usage of V0 was creating issue. I have
> > verified this with previous version of code ( working code before
> > David's instruction rearrangement patch.) .
> 
> Argh.  It's not very clearly commented, but it looks as if the system 
> call trap handler has an implicit assumption that v0 has never been 
> changed by SAVE_SOME, TRACE_IRQS_ON_RELOAD, or STI.  So yeah, moving the 
> code around to fix the v1 conflict ends up being better than using v0 - 
> otherwise, we'd need to add a LONG_L v0, PT_R2(sp) somewhere after the 
> LONG_S v0, PT_TCSTATUS(sp) of the original patch.
Well, Here is the patch.

diff --git a/arch/mips/include/asm/stackframe.h
b/arch/mips/include/asm/stackframe.h
index 58730c5..19418c4 100644
--- a/arch/mips/include/asm/stackframe.h
+++ b/arch/mips/include/asm/stackframe.h
@@ -187,8 +187,6 @@
 		 * need it to operate correctly
 		 */
 		LONG_S	$0, PT_R0(sp)
-		mfc0	v1, CP0_STATUS
-		LONG_S	$2, PT_R2(sp)
 #ifdef CONFIG_MIPS_MT_SMTC
 		/*
 		 * Ideally, these instructions would be shuffled in
@@ -199,6 +197,8 @@
 		.set	mips0
 		LONG_S	v1, PT_TCSTATUS(sp)
 #endif /* CONFIG_MIPS_MT_SMTC */
+		mfc0	v1, CP0_STATUS
+		LONG_S	$2, PT_R2(sp)
 		LONG_S	$4, PT_R4(sp)
 		LONG_S	$5, PT_R5(sp)
 		LONG_S	v1, PT_STATUS(sp)


> 
>              Regards,
> 
>              Kevin K.
