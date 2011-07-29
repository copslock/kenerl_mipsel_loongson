Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jul 2011 07:33:39 +0200 (CEST)
Received: from mail-qy0-f170.google.com ([209.85.216.170]:47916 "EHLO
        mail-qy0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490988Ab1G2Fdb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Jul 2011 07:33:31 +0200
Received: by qyg14 with SMTP id 14so3100940qyg.15
        for <multiple recipients>; Thu, 28 Jul 2011 22:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8yQRqh8LI931lfAfsERrOCOtyRo8krVWc9s2uz0iYts=;
        b=Zpfdg8tD0PJvkkaXYz1SFj7HXEkj4D4WJc9M7HNN/UMmyL4M1NfUm/BzYOq8TTg97d
         jzZerUE77FFvHd/OGeCmknl+EAM3pNzKZw0vkjCoctCOjygl9p8Sd5QoKS5Y9klX6s+L
         0HH1Znudg/5EZTXK6gMvH1CbfSLIJ66OBklcc=
MIME-Version: 1.0
Received: by 10.229.191.148 with SMTP id dm20mr676577qcb.89.1311917605216;
 Thu, 28 Jul 2011 22:33:25 -0700 (PDT)
Received: by 10.229.192.8 with HTTP; Thu, 28 Jul 2011 22:33:25 -0700 (PDT)
In-Reply-To: <20110728115330.GA29899@linux-mips.org>
References: <1311852512-7340-1-git-send-email-dengcheng.zhu@gmail.com>
        <1311852512-7340-2-git-send-email-dengcheng.zhu@gmail.com>
        <20110728115330.GA29899@linux-mips.org>
Date:   Fri, 29 Jul 2011 13:33:25 +0800
Message-ID: <CAOfQC98pw9gh6rDTjagsBvNdATt5fcF9g0wj5s7hzwY7iiJ5Yg@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: make pci_claim_resource() work with conflict
 resources as appropriate
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     jbarnes@virtuousgeek.org, torvalds@linux-foundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, eyal@mips.com, zenon@mips.com
Content-Type: multipart/alternative; boundary=00163628480cd560ff04a92e9e7c
X-archive-position: 30759
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 21390

--00163628480cd560ff04a92e9e7c
Content-Type: text/plain; charset=ISO-8859-1

I noticed that at 79896cf42f Linus changed the function from
insert_resource()
to request_resource() (and later evolved into request_resource_conflict())
and
he explained the reason. So, in the NIC's case, the problem is that in
pci_claim_resource() the function pci_find_parent_resource() returns the
root
(0x0-0xffffff) rather than the MSC PCI I/O (0x1000-0xffffff). So
request_resource_conflict() for PCI quirks (0x1000-0x103f and 0x1100-0x110f)
will simply return an error, coz these 2 regions 'conflict' with MSC PCI
I/O.
Instead, insert_resource_conflict() will also find the collisions but
register
quirks as children of MSC PCI I/O (is this supposed to be correct?) and
return
a success.


Deng-Cheng

2011/7/28 Ralf Baechle <ralf@linux-mips.org>

> On Thu, Jul 28, 2011 at 07:28:31PM +0800, Deng-Cheng Zhu wrote:
>
> > In resolving a network driver issue with the MIPS Malta platform, the
> root
> > cause was traced into pci_claim_resource():
> >
> > MIPS System Controller's PCI I/O resources stay in 0x1000-0xffffff. When
> > PCI quirks start claiming resources using request_resource_conflict(),
> > collisions happen and -EBUSY is returned, thereby rendering the onboard
> AMD
> > PCnet32 NIC unaware of quirks' region and preventing the NIC from
> functioning.
> > For PCI quirks, PIIX4 ACPI is expected to claim 0x1000-0x103f, and PIIX4
> SMB to
> > claim 0x1100-0x110f, both of which fall into the MSC I/O range.
> Certainly, we
> > can increase the start point of this range in
> arch/mips/mti-malta/malta-pci.c to
> > avoid the collisions. But a fix in here looks more justified, though it
> seems to
> > have a wider impact. Using insert_xxx as opposed to request_xxx will
> register
> > PCI quirks' resources as children of MSC I/O and return OK, instead of
> seeing
> > collisions which are actually resolvable.
>
> This used to work in the past; do you know which commit broke the resource
> handling for the NIC?
>
>  Ralf
>

--00163628480cd560ff04a92e9e7c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I noticed that at 79896cf42f Linus changed the function from insert_resourc=
e()<br>to request_resource() (and later evolved into request_resource_confl=
ict()) and<br>he explained the reason. So, in the NIC&#39;s case, the probl=
em is that in<br>
pci_claim_resource() the function pci_find_parent_resource() returns the ro=
ot<br>(0x0-0xffffff) rather than the MSC PCI I/O (0x1000-0xffffff). So<br>r=
equest_resource_conflict() for PCI quirks (0x1000-0x103f and 0x1100-0x110f)=
<br>
will simply return an error, coz these 2 regions &#39;conflict&#39; with MS=
C PCI I/O.<br>Instead, insert_resource_conflict() will also find the collis=
ions but register<br>quirks as children of MSC PCI I/O (is this supposed to=
 be correct?) and return<br>
a success.<br><br><br>Deng-Cheng<br><br><div class=3D"gmail_quote">2011/7/2=
8 Ralf Baechle <span dir=3D"ltr">&lt;<a href=3D"mailto:ralf@linux-mips.org"=
>ralf@linux-mips.org</a>&gt;</span><br><blockquote class=3D"gmail_quote" st=
yle=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204)=
; padding-left: 1ex;">
<div class=3D"im">On Thu, Jul 28, 2011 at 07:28:31PM +0800, Deng-Cheng Zhu =
wrote:<br>
<br>
&gt; In resolving a network driver issue with the MIPS Malta platform, the =
root<br>
&gt; cause was traced into pci_claim_resource():<br>
&gt;<br>
&gt; MIPS System Controller&#39;s PCI I/O resources stay in 0x1000-0xffffff=
. When<br>
&gt; PCI quirks start claiming resources using request_resource_conflict(),=
<br>
&gt; collisions happen and -EBUSY is returned, thereby rendering the onboar=
d AMD<br>
&gt; PCnet32 NIC unaware of quirks&#39; region and preventing the NIC from =
functioning.<br>
&gt; For PCI quirks, PIIX4 ACPI is expected to claim 0x1000-0x103f, and PII=
X4 SMB to<br>
&gt; claim 0x1100-0x110f, both of which fall into the MSC I/O range. Certai=
nly, we<br>
&gt; can increase the start point of this range in arch/mips/mti-malta/malt=
a-pci.c to<br>
&gt; avoid the collisions. But a fix in here looks more justified, though i=
t seems to<br>
&gt; have a wider impact. Using insert_xxx as opposed to request_xxx will r=
egister<br>
&gt; PCI quirks&#39; resources as children of MSC I/O and return OK, instea=
d of seeing<br>
&gt; collisions which are actually resolvable.<br>
<br>
</div>This used to work in the past; do you know which commit broke the res=
ource<br>
handling for the NIC?<br>
<font color=3D"#888888"><br>
 =A0Ralf<br>
</font></blockquote></div><br>

--00163628480cd560ff04a92e9e7c--
