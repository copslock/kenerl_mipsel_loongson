Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 May 2003 22:38:54 +0100 (BST)
Received: from e33.co.us.ibm.com ([IPv6:::ffff:32.97.110.131]:37370 "EHLO
	e33.co.us.ibm.com") by linux-mips.org with ESMTP
	id <S8225211AbTEEViu>; Mon, 5 May 2003 22:38:50 +0100
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e33.co.us.ibm.com (8.12.9/8.12.2) with ESMTP id h45LcdXD290622;
	Mon, 5 May 2003 17:38:40 -0400
Received: from gateway.beaverton.ibm.com (d03av02.boulder.ibm.com [9.17.193.82])
	by westrelay02.boulder.ibm.com (8.12.9/NCO/VER6.5) with ESMTP id h45LcTV3177168;
	Mon, 5 May 2003 15:38:31 -0600
Received: from dyn9-47-17-242.beaverton.ibm.com (dyn9-47-17-242.beaverton.ibm.com [9.47.17.242])
	by gateway.beaverton.ibm.com (8.11.6/8.11.6) with ESMTP id h45LZqh29608;
	Mon, 5 May 2003 14:35:52 -0700
Received: from greg by echidna.kroah.org with local (masqmail 0.2.19)
 id 19Cngp-0o0-00; Mon, 05 May 2003 14:40:03 -0700
Date: Mon, 5 May 2003 14:40:03 -0700
From: Greg KH <greg@kroah.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Petko Manolov <petkan@users.sourceforge.net>,
	Ralf Baechle <ralf@linux-mips.org>,
	linux-usb-devel@lists.sourceforge.net,
	Linux/MIPS Development <linux-mips@linux-mips.org>,
	Dimitri Torfs <Dimitri.Torfs@sonycom.com>
Subject: Re: Big endian RTL8150
Message-ID: <20030505214003.GB2941@kroah.com>
References: <Pine.GSO.4.21.0305051135140.9126-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0305051135140.9126-100000@vervain.sonytel.be>
User-Agent: Mutt/1.4.1i
Return-Path: <greg@kroah.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2275
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg@kroah.com
Precedence: bulk
X-list: linux-mips

On Mon, May 05, 2003 at 11:47:48AM +0200, Geert Uytterhoeven wrote:
> 	Hi,
> 
> The RTL8150 USB Ethernet driver doesn't work on big endian machines. Here are
> patches (for both 2.4.x and 2.5.x) to fix that. The fix was tested on the
> 2.4.20 and 2.4.21-rc1 version of the driver on big endian MIPS.

Thanks, I've applied this to my 2.4 and 2.5 trees and will forward them
on up the food chain.

greg k-h
