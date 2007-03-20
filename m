Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Mar 2007 15:52:03 +0000 (GMT)
Received: from wx-out-0506.google.com ([66.249.82.228]:46928 "EHLO
	wx-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20022193AbXCTPv7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Mar 2007 15:51:59 +0000
Received: by wx-out-0506.google.com with SMTP id t14so1865575wxc
        for <linux-mips@linux-mips.org>; Tue, 20 Mar 2007 08:50:52 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:references;
        b=V/J6Yi8EkGfhWLbdHijvzoPT/xWNfAYaRZUVv7hBQGW60igHWieLKFxdFDcvTMrUWqJCnTOKWHmkc1V/6aIyRlSFgD7iZE3S32r5E1D1P6WtNksQDjsYhpsiq6C/nbuUolp4WNhrdnJF4+4ICV/Wx7Ccktjt6Pye48ayRrEOu+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:references;
        b=JQy5jtyFBsJyOhYWQbK7EAKmGzfsyc0A9pMsDAgf8I8KVL5gteoXkakjIb0qjBShYDJqNDSPT5OKrEphM78myuVzT7Ji7ZT+O354Zqcv/OkAx+RazARZrldZgqZVb+oI1SE6P9ybyRqhKjX9S3ytLNkd18VEyiI6t74N/sPoiY8=
Received: by 10.90.56.14 with SMTP id e14mr882609aga.1174405851962;
        Tue, 20 Mar 2007 08:50:51 -0700 (PDT)
Received: by 10.114.159.16 with HTTP; Tue, 20 Mar 2007 08:50:51 -0700 (PDT)
Message-ID: <d459bb380703200850m1077be9cnecb8283750763a4f@mail.gmail.com>
Date:	Tue, 20 Mar 2007 16:50:51 +0100
From:	"Marco Braga" <marco.braga@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Re: Au1500 and TI PCI1510 cardbus
In-Reply-To: <45FFFE8B.1010806@ru.mvista.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_184689_23540238.1174405851805"
References: <d459bb380703190755n3f05b8e1v850bb8347e574d68@mail.gmail.com>
	 <200703200204.l2K24WgH020041@centurysys.co.jp>
	 <45FFEDED.6060708@ru.mvista.com>
	 <d459bb380703200747y13ba427ek83cc32b503c33bc7@mail.gmail.com>
	 <45FFFE8B.1010806@ru.mvista.com>
Return-Path: <marco.braga@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14590
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marco.braga@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_184689_23540238.1174405851805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I think I'm beginning to make a lot of confusion. Is the problem that the
PCI1510 must NOT be behind a bridge, or the problem is that PCI1510 acts as
a bridge, so cardbus cards cannot work?

This is my lspci at start:

00:0c.0 RAID bus controller: Triones Technologies, Inc. HPT371/371N (rev 02)
00:0d.0 Non-VGA unclassified device: Texas Instruments TMS320DM642 (rev 01)
00:12.0 CardBus bridge: Texas Instruments PCI1510 PC card Cardbus Controller

While this is the situation when I load yenta_socket:

00:0c.0 RAID bus controller: Triones Technologies, Inc. HPT371/371N (rev 02)
00:0d.0 Non-VGA unclassified device: Texas Instruments TMS320DM642 (rev 01)
00:12.0 CardBus bridge: Texas Instruments PCI1510 PC card Cardbus Controller
01:00.0 Network controller: 3Com Corporation 3com 3CRWE154G72 [Office
Connect Wireless LAN Adapter] (rev 01)

So it seems that the 3Com card is behind a bus. Should this work? From what
I've understood, it should now work.. In fact my problem is that it seems to
work if I try to ping a host, but it fails when I try some serious transfer.
In this case, at some point, any readl() on 3Com returns 0xFFFFFFFF. Just to
test I've tried a pci_config_read() on the PCI1510 and it fails. The entire
boards seems hung. The only thing I can do is to remove the 3Com card.

Thanks!

------=_Part_184689_23540238.1174405851805
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I think I&#39;m beginning to make a lot of confusion. Is the problem that the PCI1510 must NOT be behind a bridge, or the problem is that PCI1510 acts as a bridge, so cardbus cards cannot work?<br><br>This is my lspci at start:
<br><br>00:0c.0 RAID bus controller: Triones Technologies, Inc. HPT371/371N (rev 02)<br>00:0d.0 Non-VGA unclassified device: Texas Instruments TMS320DM642 (rev 01)<br>00:12.0 CardBus bridge: Texas Instruments PCI1510 PC card Cardbus Controller
<br><br>While this is the situation when I load yenta_socket:<br><br>00:0c.0 RAID bus controller: Triones Technologies, Inc. HPT371/371N (rev 02)<br>00:0d.0 Non-VGA unclassified device: Texas Instruments TMS320DM642 (rev 01)
<br>00:12.0 CardBus bridge: Texas Instruments PCI1510 PC card Cardbus Controller<br>01:00.0 Network controller: 3Com Corporation 3com 3CRWE154G72 [Office Connect Wireless LAN Adapter] (rev 01)<br><br>So it seems that the 3Com card is behind a bus. Should this work? From what I&#39;ve understood, it should now work.. In fact my problem is that it seems to work if I try to ping a host, but it fails when I try some serious transfer. In this case, at some point, any readl() on 3Com returns 0xFFFFFFFF. Just to test I&#39;ve tried a pci_config_read() on the PCI1510 and it fails. The entire boards seems hung. The only thing I can do is to remove the 3Com card.
<br><br>Thanks!<br><br>

------=_Part_184689_23540238.1174405851805--
