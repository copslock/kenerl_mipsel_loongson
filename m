Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Mar 2007 14:20:23 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.186]:141 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20037495AbXCEOUT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Mar 2007 14:20:19 +0000
Received: by nf-out-0910.google.com with SMTP id l24so2015840nfc
        for <linux-mips@linux-mips.org>; Mon, 05 Mar 2007 06:19:18 -0800 (PST)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=OMRWmGY/vN/XEgbbaxTZYnNptGOzeXc9HpRJxGjlUbYQ4wYQDDT6Gb6RDqZJn/EuREA5buO3sJdNMCCIAJBKYPhD7AgVHFkqlSIX2vGzXlMxTuWVTmjsvbKAFYFI0DSmT5YmKTojru3mG+V4RYSrvVClV9qEbxUOTXgOhb5CXng=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=U0Ccd9MHFBN6vYEZ5m0RR6nmjeV8jeCzHJTHpXRbCi9AzrpVRIy8KkPR2Z1hEr//uLp8X0Ux1UrBZtjpd5xAKnNVwgbb/fNDTJslb2XAY+MU8oSAipL4P/akJW4cs+Wnr5gNQhCnJykBHP+9CxfG4kRK/81pmd0pu0nXc8/K/Xo=
Received: by 10.78.192.20 with SMTP id p20mr626592huf.1173104358198;
        Mon, 05 Mar 2007 06:19:18 -0800 (PST)
Received: by 10.78.44.13 with HTTP; Mon, 5 Mar 2007 06:19:18 -0800 (PST)
Message-ID: <c4357ccd0703050619r6b5a7452j6b582687bf1794d3@mail.gmail.com>
Date:	Mon, 5 Mar 2007 16:19:18 +0200
From:	"Alexander Sirotkin" <demiourgos@gmail.com>
To:	linux-mips@linux-mips.org
Subject: 0 function size
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <demiourgos@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14354
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: demiourgos@gmail.com
Precedence: bulk
X-list: linux-mips

I'm trying to see the function sizes for some object file compiled for
MIPS. On x86 one can use objdump  or readelf to see the sizes, however
for same weird reason on MIPS these routines show 0 for all functions.

Any idea what I'm missing ?
