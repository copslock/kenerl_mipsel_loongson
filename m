Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Feb 2004 22:13:28 +0000 (GMT)
Received: from cpc1-cwma1-5-0-cust4.swan.cable.ntl.com ([IPv6:::ffff:80.5.120.4]:17315
	"EHLO dhcp23.swansea.linux.org.uk") by linux-mips.org with ESMTP
	id <S8225594AbUBXWNZ>; Tue, 24 Feb 2004 22:13:25 +0000
Received: from dhcp23.swansea.linux.org.uk (localhost.localdomain [127.0.0.1])
	by dhcp23.swansea.linux.org.uk (8.12.10/8.12.10) with ESMTP id i1OM9s0r023025;
	Tue, 24 Feb 2004 22:09:54 GMT
Received: (from alan@localhost)
	by dhcp23.swansea.linux.org.uk (8.12.10/8.12.10/Submit) id i1OM9qXU023023;
	Tue, 24 Feb 2004 22:09:52 GMT
X-Authentication-Warning: dhcp23.swansea.linux.org.uk: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: IDE driver problem
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	"Liu Hongming (Alan)" <alanliu@trident.com.cn>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <15F9E1AE3207D6119CEA00D0B7DD5F680219C648@TMTMS>
References: <15F9E1AE3207D6119CEA00D0B7DD5F680219C648@TMTMS>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1077660589.22906.7.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date:	Tue, 24 Feb 2004 22:09:50 +0000
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4435
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Maw, 2004-02-24 at 05:09, Liu Hongming (Alan) wrote:
> Hi All,
> 
> I am porting IDE drivers(Since my hardware has endian issue),
> and now it could work,however it has some abnormal problems:

Sounds like your partition data reading is wrong. Print out the
partition table bases and see if they are all zero
