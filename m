Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Apr 2006 09:40:39 +0100 (BST)
Received: from nproxy.gmail.com ([64.233.182.185]:48112 "EHLO nproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133433AbWDDIkb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 4 Apr 2006 09:40:31 +0100
Received: by nproxy.gmail.com with SMTP id p77so1106470nfc
        for <linux-mips@linux-mips.org>; Tue, 04 Apr 2006 01:51:38 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=oAXOEcUcdDRyTnV5roUTSEd3fpqp4c3CpurMKKpX9wU+VbCPTZCLI21rW4UA+KZReTYbiLyHs5h0y+v5ahr4+2L5pDDv62dpKasrDkhrPyZxYLgD261pzei+AvzgYVfY8l7sNi/kXt4qB4KBgVMHgwEDJhKs7oTZDTWR0GznBH0=
Received: by 10.49.32.7 with SMTP id k7mr232378nfj;
        Tue, 04 Apr 2006 01:51:38 -0700 (PDT)
Received: by 10.48.241.10 with HTTP; Tue, 4 Apr 2006 01:51:38 -0700 (PDT)
Message-ID: <38dc7fce0604040151l4bbe5c1tb511cc0ca96e598d@mail.gmail.com>
Date:	Tue, 4 Apr 2006 17:51:38 +0900
From:	"Youngduk Goo" <ydgoo9@gmail.com>
To:	linux-mips@linux-mips.org
Subject: JFFS2 error.(SMP8634)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <ydgoo9@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11021
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ydgoo9@gmail.com
Precedence: bulk
X-list: linux-mips

Hello,  all

I am porting the linux 2.6.15 to the SMP8634(SOC based on the MIPS 4
Kec , Sigma Design).
The booting and mount the rootfilesystem is fine with JFFS2.
But When I try to write the file more than 4KB,It makes error like
"Data CRC a81daeb5 != calculated CRC 349cadd9 for node at 0093bc64"
But the file smaller tha 4KB, it is OK.
My Flash is S29GL512N or S29GL256N from spansion.

If you have a experience about the SMP8634, please share the
information with me.
or any other advice about the Flash, JFFS2 are welcome.

Thanks,
youngduk
