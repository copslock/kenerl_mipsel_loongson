Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Dec 2002 22:38:17 +0000 (GMT)
Received: from pc2-cwma1-4-cust129.swan.cable.ntl.com ([213.105.254.129]:30660
	"EHLO irongate.swansea.linux.org.uk") by linux-mips.org with ESMTP
	id <S8225241AbSLKWiR>; Wed, 11 Dec 2002 22:38:17 +0000
Received: from irongate.swansea.linux.org.uk (localhost [127.0.0.1])
	by irongate.swansea.linux.org.uk (8.12.5/8.12.5) with ESMTP id gBBNFplQ019394;
	Wed, 11 Dec 2002 23:15:52 GMT
Received: (from alan@localhost)
	by irongate.swansea.linux.org.uk (8.12.5/8.12.5/Submit) id gBBNFm6S019392;
	Wed, 11 Dec 2002 23:15:49 GMT
X-Authentication-Warning: irongate.swansea.linux.org.uk: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: [PATCH 2.5] SGI O2 framebuffer driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Vivien Chappelier <vivienc@nerim.net>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Ilya Volynets <ilya@theIlya.com>
In-Reply-To: <Pine.LNX.4.21.0212112252410.2300-100000@melkor>
References: <Pine.LNX.4.21.0212112252410.2300-100000@melkor>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Dec 2002 23:15:48 +0000
Message-Id: <1039648548.18587.52.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 870
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Wed, 2002-12-11 at 22:25, Vivien Chappelier wrote:
> Hi,
> 
> 	Here's a patch to add support for the framebuffer on the SGI
> O2. It has support for both static (bootmem) and dynamic video memory
> allocation (limited to 2MB due to the small number of available vmalloc
> mappings in the current mips64 kernel). 

Since vmalloc is physically non linear is there any reason you can't
just use get_free_page() a lot ?
