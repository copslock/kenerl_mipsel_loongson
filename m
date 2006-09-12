Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Sep 2006 12:40:46 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.186]:22381 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20037548AbWILLko (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 12 Sep 2006 12:40:44 +0100
Received: by nf-out-0910.google.com with SMTP id l23so1630313nfc
        for <linux-mips@linux-mips.org>; Tue, 12 Sep 2006 04:40:43 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=EBGSI+Wbd+wSQqR9RXqTq5ZHJPbZ+6UBGyrGjlRaERpGeo/ZZ1nDQGwW/HBPrb8VS+G21QZj5LaVl3Ztt3xA+V0DD7aWgPquaRPSPuuNZ/g5+xfbm5uYVOm/vwiwnOlnW7z56XWKMaermnN0YT89gR9+PfdPOfvXdeeN+hNSRMs=
Received: by 10.49.90.4 with SMTP id s4mr9434688nfl;
        Tue, 12 Sep 2006 04:40:43 -0700 (PDT)
Received: by 10.48.238.18 with HTTP; Tue, 12 Sep 2006 04:40:43 -0700 (PDT)
Message-ID: <38dc7fce0609120440o11c6a11ejf7f0a3cb1371bb40@mail.gmail.com>
Date:	Tue, 12 Sep 2006 20:40:43 +0900
From:	"Youngduk Goo" <ydgoo9@gmail.com>
To:	linux-mips@linux-mips.org
Subject: NOR Flash memory write speed.
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <ydgoo9@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12564
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ydgoo9@gmail.com
Precedence: bulk
X-list: linux-mips

Hello, all

I am developing the system using the NOR flash (32MB) and the core is
about 300MHz mips.
I wonder how long takes the whole erase and write time to flash memory.
I tried it on the bootloader. Firstof all, bootloader(YAMON) load the image
and erase the flash except bootloader region, write the image..
It took about 14-16minutes.I think it is too long.

I would like to know, for you, normally how long it tasks ?

Thanks,
