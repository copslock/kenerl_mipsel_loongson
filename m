Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Dec 2009 08:39:24 +0100 (CET)
Received: from mail-bw0-f221.google.com ([209.85.218.221]:60140 "EHLO
        mail-bw0-f221.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492375AbZLGHjV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Dec 2009 08:39:21 +0100
Received: by bwz21 with SMTP id 21so3221519bwz.24
        for <linux-mips@linux-mips.org>; Sun, 06 Dec 2009 23:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=rrB6iqrsspkvWD09xu0DGxKmbycwnyF/NNXck+c4+ao=;
        b=beTUz4EIwwIfvMJyS0umrJM2Ec+TO4jDVdyBtfKakzrQVoj6WbJVEq3uZvsr5rpB6M
         RXXW8qsdfLVAs59tFxFhH7jY2Y5Q4xuISOoANSqNRTc9u7JysrkO8bkmgsKE+CAabnI7
         hrE6MTh3wQB+obbKLtPhROT9sNINpaQ9waDrs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=F6RZ290/fQmt1vKuo5Owj72/uxvr7lInDUJwGjXYej/zVUexYUATEJhL9pSQfvQAxI
         IeO3RIhUXZBcTdtMJlKRuGhJlvHKmkkjnJM/9I3pB29f/byKi+xL+y7n1J2rw+zVWzU4
         3NBIVxHr/uiKCyYn+ABadJ/3jbVmjNXZ3HCqY=
MIME-Version: 1.0
Received: by 10.204.34.71 with SMTP id k7mr6523203bkd.206.1260171556004; Sun, 
        06 Dec 2009 23:39:16 -0800 (PST)
Date:   Mon, 7 Dec 2009 15:39:15 +0800
Message-ID: <7b09df4c0912062339g418f432cr28d92c18ed273d2@mail.gmail.com>
Subject: Question: about Physical Address mapping
From:   "Dennis.Yxun" <dennis.yxun@gmail.com>
To:     linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=00032555b73ef3a5a6047a1e8d1f
Return-Path: <dennis.yxun@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25343
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dennis.yxun@gmail.com
Precedence: bulk
X-list: linux-mips

--00032555b73ef3a5a6047a1e8d1f
Content-Type: text/plain; charset=ISO-8859-1

HI ALL:
   I have a problem, that our MIPS hardware put registers location from
0x7000,0000 -0x7040,0000.
So, I need to init TLB to access those registers.
   My question is: can I map those range to Kseg2 (mapped,uncached)? I found
"add_wired_entry" sit in
kernel code, seems I should use this function.

   I found code in arch/mips/jazz/irq.c, and the comment tells me
/* Map 0xe4000000 -> 0x0:600005C0, 0xe4100000 -> 400005C0 */
   add_wired_entry(0x01800017, 0x01000017, 0xe4000000, PM_4M);

does that mean after add_wired_entry, virtual address 0xe400,0000 map to
physical address 0x600005C0?
why the address is 0x6000,05C0, not 0x6000,0000

Thanks

Dennis

--00032555b73ef3a5a6047a1e8d1f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

HI ALL:<br>=A0=A0 I have a problem, that our MIPS hardware put registers lo=
cation from 0x7000,0000 -0x7040,0000.<br>So, I need to init TLB to access t=
hose registers.<br>=A0=A0 My question is: can I map those range to Kseg2 (m=
apped,uncached)? I found &quot;add_wired_entry&quot; sit in<br>

kernel code, seems I should use this function. <br><br>=A0=A0 I found code =
in arch/mips/jazz/irq.c, and the comment tells me<br>/* Map 0xe4000000 -&gt=
; 0x0:600005C0, 0xe4100000 -&gt; 400005C0 */<br>=A0=A0 add_wired_entry(0x01=
800017, 0x01000017, 0xe4000000, PM_4M);<br>

<br>does that mean after add_wired_entry, virtual address 0xe400,0000 map t=
o physical address 0x600005C0?<br>why the address is 0x6000,05C0, not 0x600=
0,0000<br><br>Thanks<br><br>Dennis<br>

--00032555b73ef3a5a6047a1e8d1f--
