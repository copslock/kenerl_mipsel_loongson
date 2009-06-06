Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Jun 2009 18:26:10 +0100 (WEST)
Received: from mail-fx0-f223.google.com ([209.85.220.223]:55335 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022453AbZFFR0C convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 6 Jun 2009 18:26:02 +0100
Received: by fxm23 with SMTP id 23so2239203fxm.0
        for <multiple recipients>; Sat, 06 Jun 2009 10:25:57 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=fvW1GAu//GGtmEzPQzt+2QsvAagDsc2UuIfbv/uFrJg=;
        b=ozf7r4eUWEf9rZr9EXtxdWLgniRR9BRdPjq+LlSLKlga1cNJGwXwsiw5eETMHBUBFe
         vfLx+/P411hs6ltKC/Lxu5ugqqAS8s1kZGaaEm2qT5HXoun/LE0V70ugmKJoYrofM0DA
         O1d1SLG/SBBjMsKM6bA+NOiNgRNF112tlM4oQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ZRKCZgdjaDlS2VwTc37uRR15iOgD9BhEQr7AX0vOWgGRjoxHr0vIVx+yasX0cuFQX4
         OBhK0CDIvy1TGoreuhL1rhUgOhIEjTx8T23Y+1Il/mu8+YTs4HhI0CtTR4AXb4Tml5Es
         5eBbHE1aCp2FmJX7SR2EzdwICZFjtDk+5hj6Q=
Received: by 10.86.86.10 with SMTP id j10mr5188637fgb.37.1244309156986;
        Sat, 06 Jun 2009 10:25:56 -0700 (PDT)
Received: from florian (207.130.195-77.rev.gaoland.net [77.195.130.207])
        by mx.google.com with ESMTPS id 4sm2821157fgg.13.2009.06.06.10.25.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Jun 2009 10:25:56 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH 8/8] 8250: add Texas Instruments AR7 internal UART
Date:	Sat, 6 Jun 2009 19:25:52 +0200
User-Agent: KMail/1.9.9
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-serial@vger.kernel.org
References: <200906041622.47591.florian@openwrt.org> <20090604222020.GA14843@alpha.franken.de>
In-Reply-To: <20090604222020.GA14843@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200906061925.53839.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23315
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le Friday 05 June 2009 00:20:20 Thomas Bogendoerfer, vous avez écrit :
> On Thu, Jun 04, 2009 at 04:22:46PM +0200, Florian Fainelli wrote:
> > We discussed that in private, there are a couple of things
> > to fix in order to get 8250 working properly with TI AR7 HW.
> > If you can still merge that bit, this would ease future work, thanks !
>
> I still have a tree here, which works without any changes to the 8250
> serial driver on a TNETD7300 device.

Got to test with defining the UART type as a PORT_16550 and use UPIO_MEM32 
instead of UPIO_MEM.
-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
