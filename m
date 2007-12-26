Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Dec 2007 06:38:34 +0000 (GMT)
Received: from hs-out-0708.google.com ([64.233.178.243]:1322 "EHLO
	hs-out-2122.google.com") by ftp.linux-mips.org with ESMTP
	id S20025627AbXLZGi0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Dec 2007 06:38:26 +0000
Received: by hs-out-2122.google.com with SMTP id l65so1671460hsc.0
        for <linux-mips@linux-mips.org>; Tue, 25 Dec 2007 22:38:25 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type;
        bh=i1QMaUx7s5Jrdzp4N3BGtRjr7ocTU5iOoJmbJjxZ26I=;
        b=WmJqEtDU6q2c6k3nz5RUjnrbfEDY+ds6xquoBKq3VTR+FLUGTSlL2hGHSJsYipaA7smWejJx+Isp1YQdc0NrVavYF5a9x4/fLzoXkK2vK9p+Q7f6caqCX860C7+KN9pD9j9qTgkxCEBom4+7BU6KCJAvZsINLEtevKtrfsNSTII=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type;
        b=f3R5g/uHWUWUqJPwU0J//uthDoWGNPG5ZMgul3Ngt2p/75IzD686A9ZPmTu8pLlHsBqFRXsv7FGeHutsOfPJBHfH9YLsOaMcU6AaIUjV1gjYouzhBBDvL0zw0cw8+KZMrlUhpSuVtL12+r1NDtjyzB/DnnaiHzvhlQRZjtEKivA=
Received: by 10.150.157.11 with SMTP id f11mr1602162ybe.108.1198651104817;
        Tue, 25 Dec 2007 22:38:24 -0800 (PST)
Received: by 10.150.51.3 with HTTP; Tue, 25 Dec 2007 22:38:24 -0800 (PST)
Message-ID: <47f174260712252238x80b76arafa15a0153d3f40d@mail.gmail.com>
Date:	Wed, 26 Dec 2007 14:38:24 +0800
From:	"Zhou YaJin" <zyj001et@gmail.com>
To:	linux-mips@linux-mips.org
Subject: admulator: a simulator of adm5120
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_2875_25263922.1198651104811"
Return-Path: <zyj001et@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17881
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zyj001et@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_2875_25263922.1198651104811
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi everyone, I am glad to release admulator-a simulator of adm5120.
Currently it can run linux 2.6 kernel and openwrt.
website:
http://admulator.sf.net
If you have any question about admulator, please contact me. Thanks :)

Admulator is a full system simulator of adm5120 soc. It simulates a mips32
cpu core and other devices. Currently it can run linux 2.6 kernel and
openwrt for adm5120. The entire source code of admulator is distributed
under GPL.

Some of the features include:

   - full system simulation. the ability to run unmodified linux kernel
   and openwrt.
   - mips32 cpu core without fpu support
   - 4Mbytes flash simulation(including CFI Interface)
   - duart simulation
   - gdb interface

Missing features :

   - no switch core simulation in current release
   - no binary translation

------=_Part_2875_25263922.1198651104811
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi everyone, I am glad to release admulator-a simulator of adm5120. Currently it can run linux 2.6 kernel and openwrt.<br>website: <br><a href="http://admulator.sf.net">http://admulator.sf.net</a><br>If you have any question about admulator, please contact me. Thanks :)
<br><p>Admulator is a full system simulator of adm5120 soc. It simulates a
mips32 cpu core and other devices. Currently it can run linux 2.6
kernel and openwrt for adm5120. The entire source code of admulator is
distributed under GPL.
</p><p>Some of the features include:
</p>
<ul><li> full system simulation. the ability to run unmodified linux kernel and openwrt.
</li><li> mips32 cpu core without fpu support
</li><li> 4Mbytes flash simulation(including CFI Interface)
</li><li> duart simulation
</li><li> gdb interface
</li></ul>
<p>Missing features&nbsp;:
</p>
<ul><li> no switch core simulation in current release
</li><li> no binary translation
</li></ul><br><br><br><br>

------=_Part_2875_25263922.1198651104811--
