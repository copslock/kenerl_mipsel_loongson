Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Sep 2010 15:05:01 +0200 (CEST)
Received: from mail-qy0-f177.google.com ([209.85.216.177]:47627 "EHLO
        mail-qy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491018Ab0IUNE6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Sep 2010 15:04:58 +0200
Received: by qyk34 with SMTP id 34so6282354qyk.15
        for <linux-mips@linux-mips.org>; Tue, 21 Sep 2010 06:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type;
        bh=Su8itA51Pf3e8hBd1vuisyyKzDcRgVB+g+JpyomKSic=;
        b=PazmJdI/8bNChweBqTc2TZq0IrpKJS8vFDX9KYBt2DyHjsYUN0b+tuAZhe7n/A1E6l
         2PqoVd1eCwMbHp3p4/rMylEnRSQiVA89ahElbcC/eAA6uTIR0+FK0FlTyCE6NDBpKArP
         fIMF1+hwt4+89vx8fFwYb3W5UtMZr5F9zetA8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=Q4eUpFtZADo5IzdiVNtGErTDoW9/Nr9HIv+QAIv6AYEIU4DhfT/JcEt+gDtL0elOiT
         r6fy16GImkLbkMsdcCQUe1FwkjStgs47g4BZNhplsYcvWTB8ff12aPkpHiRgmsfFmgdz
         XcYLTFoMNP7JNpcWF2KjO1uBlS/x9VTjsM4ks=
MIME-Version: 1.0
Received: by 10.229.232.14 with SMTP id js14mr7254350qcb.103.1285074292564;
 Tue, 21 Sep 2010 06:04:52 -0700 (PDT)
Received: by 10.229.25.139 with HTTP; Tue, 21 Sep 2010 06:04:52 -0700 (PDT)
In-Reply-To: <AANLkTimCEAzvya1zH0BRvHtn7=PhZPHgPG2LMzquhjGy@mail.gmail.com>
References: <AANLkTimCEAzvya1zH0BRvHtn7=PhZPHgPG2LMzquhjGy@mail.gmail.com>
Date:   Tue, 21 Sep 2010 21:04:52 +0800
Message-ID: <AANLkTikVu=LdkiP_beBTbXBz7VjggCW4qcHwJcUupZDg@mail.gmail.com>
Subject: Re: [HELP] Oops when insmod iptable_filter
From:   arrow zhang <arrow.ebd@gmail.com>
To:     linux-mips@linux-mips.org,
        OpenWrt <openwrt-devel@lists.openwrt.org>
Content-Type: text/plain; charset=UTF-8
X-archive-position: 27779
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arrow.ebd@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 16255

On Fri, Sep 17, 2010 at 8:55 PM, arrow zhang <arrow.ebd@gmail.com> wrote:
> Here has a difficult problem for me, would like anyone give some advice
>
> On a mips r3000 cpu, here has a kernel crash when doing the insmod
> iptable_filter,
> The phenomenon is same as https://dev.openwrt.org/ticket/6129
>
> 1, the FW is at openwrt versoin r23057
> 2, the crash occurs if insmod automatically by preinit
> 3, but not has crash if insmod within "failsafe mode"
----

good news:

1, work fine if start "init" without "env, like this:
    exec $pi_init_cmd 2>&0
2, test patch:
{{{
diff --git a/package/base-files/files/lib/preinit/99_10_run_init
b/package/base-files/files/lib/preinit/99_10_run_init
index fef3a50..7db1e72 100644
--- a/package/base-files/files/lib/preinit/99_10_run_init
+++ b/package/base-files/files/lib/preinit/99_10_run_init
@@ -6,9 +6,11 @@ run_init() {
     preinit_echo "- init -"
     preinit_ip_deconfig
     if [ "$pi_init_suppress_stderr" = "y" ]; then
-	exec env - PATH=$pi_init_path $pi_init_env $pi_init_cmd 2>&0
+	#exec env - PATH=$pi_init_path $pi_init_env $pi_init_cmd 2>&0
+	exec $pi_init_cmd 2>&0
     else
-	exec env - PATH=$pi_init_path $pi_init_env $pi_init_cmd
+	#exec env - PATH=$pi_init_path $pi_init_env $pi_init_cmd
+	exec $pi_init_cmd
     fi
 }

}}}}

3, I do not know why, I think it's a my mips SOC porting issue, but I
tried to modify TLB and cache, not find out yet, would like someone
have advice
