Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Feb 2006 05:26:12 +0000 (GMT)
Received: from nproxy.gmail.com ([64.233.182.198]:44707 "EHLO nproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8127231AbWBUF0C convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 21 Feb 2006 05:26:02 +0000
Received: by nproxy.gmail.com with SMTP id x30so696188nfb
        for <linux-mips@linux-mips.org>; Mon, 20 Feb 2006 21:33:03 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Wu0h4EB13IToimQz0+FfJZcoDbDBZdPqXTB0qifOrr3+SV++sOu4OUHsZyZsbRUjaKUewqKVWYCToTLUFxdjNsQPqVurZtCr7g4i7Zm6xs4ORfXBUjca6tjg3Jy3UC1WxqQRqIAREPKhYqOeD4Vyg1Hdnq57vEgt0FasiYEHlWU=
Received: by 10.48.238.3 with SMTP id l3mr1413915nfh;
        Mon, 20 Feb 2006 21:33:03 -0800 (PST)
Received: by 10.48.250.13 with HTTP; Mon, 20 Feb 2006 21:33:03 -0800 (PST)
Message-ID: <50c9a2250602202133g2e7350aesdaf1df810c90cef8@mail.gmail.com>
Date:	Tue, 21 Feb 2006 13:33:03 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: "Hw. address read/write mismap 0" or RTL8019 ethernet in linux
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10586
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

i want to add a RTL8019 ethernet driver for my board, when i run the
linux, at the init of ethernet, it get

eth0: trigger_send() called with the transmitter busy.
.<6>NETDEV WATCHDOG: eth0: transmit timed out
Hw. address read/write mismap 0
Hw. address read/write mismap 1
Hw. address read/write mismap 2
Hw. address read/write mismap 3
Hw. address read/write mismap 4
Hw. address read/write mismap 5

then i check the code and find it's in 8390.c, caused by uncorrect
write of MAC addr, and now i repalce all the inb,outb,inb_p, outb_p
with get_reg and put_reg in the 8390.c.as follow:

static unsigned char get_reg (unsigned int regno)
{
	return (*(volatile unsigned char *) regno);
}

static void put_reg (unsigned int regno, unsigned char val)
{
	*(volatile unsigned char *) regno = val;
}

 it can run over t he ethernet init, and it also can mount nfs root
fs, it can ping and responding to ping, and also can do copy,delete in
the nfs root.
 but when i run  application in nfs root, it get message as follow,
and hang on it
"nfs: server 192.168.81.142 not responding, still trying"

does someone have any idea of this situation?

thanks for any hints

Best regards

zhuzhenhua
