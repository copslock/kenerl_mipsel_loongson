Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Apr 2003 00:03:10 +0100 (BST)
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([IPv6:::ffff:213.105.254.86]:4833
	"EHLO lxorguk.ukuu.org.uk") by linux-mips.org with ESMTP
	id <S8225201AbTDVXDK>; Wed, 23 Apr 2003 00:03:10 +0100
Received: from dhcp22.swansea.linux.org.uk (dhcp22.swansea.linux.org.uk [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.12.8/8.12.5) with ESMTP id h3MM5CRN015855;
	Tue, 22 Apr 2003 23:05:13 +0100
Received: (from alan@localhost)
	by dhcp22.swansea.linux.org.uk (8.12.8/8.12.8/Submit) id h3MM5BE7015853;
	Tue, 22 Apr 2003 23:05:11 +0100
X-Authentication-Warning: dhcp22.swansea.linux.org.uk: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: ide_ops issues for big endian mips
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lyle Bainbridge <lyle@zevion.com>
Cc: linux-mips@linux-mips.org
In-Reply-To: <000801c30920$df9a4a20$1301a8c0@RADIUM>
References: <000801c30920$df9a4a20$1301a8c0@RADIUM>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051049110.15763.1.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 Apr 2003 23:05:11 +0100
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2140
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Maw, 2003-04-22 at 23:45, Lyle Bainbridge wrote:
> provided some IDE operations ide_insw, ide_outsw,
> ide_insl and ide_outsl, that didn't use the standard
> io.h functions (insw, outsw, insl, outsl) but instead 
> provided some special IDE versions that didn't do the
> byte swapping done by the standard calls.

A port can override these. PowerPC does the neccessary since
it also has deeply broken I/O functions.
