Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Aug 2011 21:35:57 +0200 (CEST)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:43830 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491192Ab1HBTfv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Aug 2011 21:35:51 +0200
Received: by yxj20 with SMTP id 20so73713yxj.36
        for <multiple recipients>; Tue, 02 Aug 2011 12:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=MAaxV2IZ2j3KN7XOF/1Z9z+QFSFyLEHl/A6ymZn30TY=;
        b=wvAVRHBJYLIqMkHr8aUpeC8VGsVAwVJ3fss+jiRQB12UNf24ngaQF4LLeKU6cqnJdy
         Sm5YUlvEf4wrYui5A8s3WT+vM77AOhun7ZLmsAWSNoGfYC9/T/IxrzQuiy+2kj/Rnnpp
         Qo3i7LDfjd6TeMw+/8ID4vPunM7licm+FxF2Q=
MIME-Version: 1.0
Received: by 10.236.187.1 with SMTP id x1mr4608560yhm.358.1312313744774; Tue,
 02 Aug 2011 12:35:44 -0700 (PDT)
Received: by 10.236.103.172 with HTTP; Tue, 2 Aug 2011 12:35:44 -0700 (PDT)
In-Reply-To: <20110802193159.GB15961@linux-mips.org>
References: <1312307470-6841-1-git-send-email-manuel.lauss@googlemail.com>
        <1312307470-6841-14-git-send-email-manuel.lauss@googlemail.com>
        <20110802193159.GB15961@linux-mips.org>
Date:   Tue, 2 Aug 2011 21:35:44 +0200
Message-ID: <CAOLZvyFECGNO1bJ3_oOSkSNhv9pxSe-wstzTWcg5mPAaaqmqAg@mail.gmail.com>
Subject: Re: [PATCH 13/15] MIPS: remove __init from add_wired_entry()
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: multipart/alternative; boundary=20cf305e255197573c04a98ada3a
X-archive-position: 30816
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 1694

--20cf305e255197573c04a98ada3a
Content-Type: text/plain; charset=ISO-8859-1

On Tuesday, August 2, 2011, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Tue, Aug 02, 2011 at 07:51:08PM +0200, Manuel Lauss wrote:
>
>> For Alchemy-PCI I need to add a wired entry after resuming from RAM;
>> remove the __init from add_wired_entry() so that this actually works.
>
> This is needed for -stable and 3.1 as well, I assume?

no, no.  The patch following this one needs it,
although the problem itself (missing wired entry
after resume) has been here since the beginning.

Manuel

--20cf305e255197573c04a98ada3a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br>On Tuesday, August 2, 2011, Ralf Baechle &lt;<a href=3D"mailto:ralf=
@linux-mips.org">ralf@linux-mips.org</a>&gt; wrote:<br>&gt; On Tue, Aug 02,=
 2011 at 07:51:08PM +0200, Manuel Lauss wrote:<br>&gt;<br>&gt;&gt; For Alch=
emy-PCI I need to add a wired entry after resuming from RAM;<br>
&gt;&gt; remove the __init from add_wired_entry() so that this actually wor=
ks.<br>&gt;<br>&gt; This is needed for -stable and 3.1 as well, I assume?<b=
r><br>no, no. =A0The patch following this one needs it,<br>although the pro=
blem itself (missing wired entry<br>
after resume) has been here since the beginning.<br><br>Manuel

--20cf305e255197573c04a98ada3a--
