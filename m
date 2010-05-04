Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 May 2010 09:13:30 +0200 (CEST)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:41122 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491874Ab0EDHN0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 May 2010 09:13:26 +0200
Received: by vws8 with SMTP id 8so856549vws.36
        for <linux-mips@linux-mips.org>; Tue, 04 May 2010 00:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=kgd/EWwl8vrQ42caOEectcX3bw7K21iGvt6Pd/kgBg0=;
        b=pu3c/fWXlvnRGAOe7b1+6gXHPK5fHaNsW4qzEClubgpNWIG3EXVOWVIaSZN8fCYsr+
         TAITcZb1YJYJWr/IN61e5CVUSqP9J5UXOhpsMtWBXhGm/mWGGvvShaIGO3tmkwetJTap
         8E67g1/tDmkpFzHrCd80qZc+P4Imrr/nhkHzA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=GztCAWYP73n77ENIcKwkvbFmXfYO9iN8AdBq02TmctcCKbzNXqX/L37J6SEQEp7tIc
         ADa2U3GEpBUzDdg2XMLcri0XIiurJ1vbAvXF+n69bqvvVYPu+ZZmu0KhphVGSMbFeY3R
         JauJ4QDs+SYhfMouVE345380FSvThwgVSch5I=
MIME-Version: 1.0
Received: by 10.220.129.14 with SMTP id m14mr405120vcs.75.1272957200655; Tue, 
        04 May 2010 00:13:20 -0700 (PDT)
Received: by 10.220.19.212 with HTTP; Tue, 4 May 2010 00:13:20 -0700 (PDT)
In-Reply-To: <m2rb2b2f2321005032356j854934d9v42a9e50683b085a8@mail.gmail.com>
References: <E1O8lDn-0000Sk-86@localhost> <4BDF366E.5000501@paralogos.com>
         <k2hb2b2f2321005031843l87f39f36h960153cae3ec5020@mail.gmail.com>
         <4BDF8092.1060401@paralogos.com>
         <n2pb2b2f2321005032049h56cd72ceh3ac7120c547b59c5@mail.gmail.com>
         <n2rb2b2f2321005032135ze807a2aft8811a7937288de53@mail.gmail.com>
         <m2rb2b2f2321005032356j854934d9v42a9e50683b085a8@mail.gmail.com>
Date:   Tue, 4 May 2010 01:13:20 -0600
Message-ID: <n2gb2b2f2321005040013ua827a45fq1299d682e5d817@mail.gmail.com>
Subject: Re: Unexpected behaviour when catching SIGFPE on FPU-less system
From:   Shane McDonald <mcdonald.shane@gmail.com>
To:     "Kevin D. Kissell" <kevink@paralogos.com>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <mcdonald.shane@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26555
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips

Sorry to the list for all the noise...

One final data point:

On Tue, May 4, 2010 at 12:56 AM, Shane McDonald
<mcdonald.shane@gmail.com> wrote:
> When I'm inside my handler, I see the FCSR register has the value 0x8420,

On a machine with an FPU, when I'm inside the handler, the FCSR register
seems to have the value 0x400 (no Causes or Flags bits set),
rather than the 0x8420 that the FP emulator has.

Shane
