Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Nov 2010 00:02:44 +0100 (CET)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:51166 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492045Ab0KHXCk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Nov 2010 00:02:40 +0100
Received: by iwn8 with SMTP id 8so6746756iwn.36
        for <multiple recipients>; Mon, 08 Nov 2010 15:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type;
        bh=AsXgKyn6YsVwqo2p8+ckF93ZRnVj/KqrGbaxj5OWIC4=;
        b=Id3AMXQie+9OXfFk7rKjS6sgIa3ked/qKRJE+EqisdHYC2CGusI+ens2M82L2ugLi6
         OysZQij15eDstrXOw5adVR+nowia+MN8UGmc8IaesDiotQT2DoAFZnkGOpc+39aQoWsv
         Ha7+TxdI7PGsGNbY9AzcIc0DR6OZ5vLk+q6kk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=ZNNI7FzLa63aAHCpxpxaLNzkCL+21WNZZ+f+D8JaEt5BPxj61NblMyWtfRTDQIl63g
         KAljvrjixfsrFBTAHf6tSfr0ry4rUf3OJqH3l7fddoi9kNiKYvdDykZeWwoR5MF7OXBH
         7Xayiyh0FcEh3xKBnopQMFVgiFFfeQSj64V6A=
MIME-Version: 1.0
Received: by 10.231.14.2 with SMTP id e2mr4602841iba.160.1289257359354; Mon,
 08 Nov 2010 15:02:39 -0800 (PST)
Received: by 10.231.170.70 with HTTP; Mon, 8 Nov 2010 15:02:39 -0800 (PST)
In-Reply-To: <4CD87EC3.2060405@caviumnetworks.com>
References: <1289133059.1547.0@thorin>
        <4CD84BEA.6010607@caviumnetworks.com>
        <AANLkTikCD_HjshMiP0ubyYZkPDoRb8nkFScUPE3GB2F4@mail.gmail.com>
        <4CD87EC3.2060405@caviumnetworks.com>
Date:   Tue, 9 Nov 2010 00:02:39 +0100
X-Google-Sender-Auth: Xc26dYfUNdv0oKl4uOBUxmgrF0Q
Message-ID: <AANLkTi=HjVCbghbH3LYHQfzh=qAPBV-0q_JnfkGPXyS1@mail.gmail.com>
Subject: Re: [PATCH] Enable AT_PLATFORM for Loongson 2F CPU
From:   Robert Millan <rmh@gnu.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <rmh.aybabtu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28327
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rmh@gnu.org
Precedence: bulk
X-list: linux-mips

2010/11/8 David Daney <ddaney@caviumnetworks.com>:
> Look at the description of the register in this document:
>
> http://dev.lemote.com/files/resource/documents/Loongson/ls2e/godson2e.user.manual.pdf
>
> On page 49, it says that bits 0-3 contain the minor version number and bits
> 4-7 are the major version number (according to a workmate that reads
> Chinese).
>
> I don't know for certain, but it seems plausible that the 2E and 2F will
> differ in bits 4-7, and bits 0-3 can be ignored.

Thanks for investigating, but ignoring bits 0-3 doesn't
really change anything.  Our problem was that bits 0-7
are the same on 2E and 2F (0x02).  If we ignore bits 0-3,
then our problem is that bits 4-7 are the same on 2E
and 2F (0x2).

-- 
Robert Millan
