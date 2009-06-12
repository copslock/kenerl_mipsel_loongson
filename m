Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Jun 2009 22:35:14 +0200 (CEST)
Received: from mail-bw0-f225.google.com ([209.85.218.225]:44385 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492118AbZFLUfH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 12 Jun 2009 22:35:07 +0200
Received: by bwz25 with SMTP id 25so2817860bwz.0
        for <linux-mips@linux-mips.org>; Fri, 12 Jun 2009 13:35:01 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=bkgriaP96ZRUlhTOD36EnyI4/ozQ25WPj9ArbewRxm0=;
        b=aYxl74nvvoQqK3MNDycaAGh9/4rTRDcy3e6Yeh7bF0zUvany4+aO6Caj9eiikPWmUQ
         bax+7PXnuxU8en00DqnENtVAEm5RCkMwWrE5tq0hlUelv7z+AgiGFxCwUy5hdla67QdG
         9r3ClBbUfz94HuLeo/GA7bflT6n3a1oDFDxAY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=DZAS+FD+s3yFaqaNij/Hd1MWxycEbkERsK5myeFST09jxzRvtVXLOa5S8bK653NFXj
         AnLbS7fyiBHjlX+e067JjnvRXl8WOI69hcZdjHtCYpbl1tF0xDwOW69dI/RdUu63CrUW
         pYCeRotoaW1inAJXo4Z3MYl06VA15vE2cNOko=
MIME-Version: 1.0
Received: by 10.204.61.9 with SMTP id r9mr260858bkh.156.1244838901619; Fri, 12 
	Jun 2009 13:35:01 -0700 (PDT)
Date:	Sat, 13 Jun 2009 02:05:01 +0530
Message-ID: <eefc325c0906121335i6b575864kd10ca52948c36bd8@mail.gmail.com>
Subject: smtc support
From:	Anoop P A <an4linu@gmail.com>
To:	linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=001636c5b3fd889df3046c2ca486
Return-Path: <an4linu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23384
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: an4linu@gmail.com
Precedence: bulk
X-list: linux-mips

--001636c5b3fd889df3046c2ca486
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi List,
I have got a reference board with mips 34k core SOC.I am planning to enable
smtc/smp support . The reference kernel I am having is linux-2.6.18 which is
in uniprocessor mode.

 Could any of you suggest me in which way i have to proceed?. Does it make
sense to continue using 2.6.18 or port newer kernel version ( which might be
having better SMTC/SMP support)?

Thanks
An

--001636c5b3fd889df3046c2ca486
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi List,<div><br></div><div>I have got a reference board with mips 34k core=
 SOC.I am planning to enable smtc/smp support . The reference kernel I am h=
aving is linux-2.6.18 which is in uniprocessor mode.</div><div><br></div>
<div>=A0Could any of you suggest me in which way i have to proceed?. Does i=
t make sense to continue using 2.6.18 or port newer kernel version ( which =
might be having better SMTC/SMP support)?=A0</div><div><br></div><div>Thank=
s</div>
<div>An</div>

--001636c5b3fd889df3046c2ca486--
