Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 26 Oct 2008 12:24:43 +0000 (GMT)
Received: from fg-out-1718.google.com ([72.14.220.153]:14615 "EHLO
	fg-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S22414039AbYJZMYf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 26 Oct 2008 12:24:35 +0000
Received: by fg-out-1718.google.com with SMTP id d23so1539164fga.32
        for <linux-mips@linux-mips.org>; Sun, 26 Oct 2008 05:24:32 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id:sender;
        bh=6F7ZG+zVTywoIH1tVGzqGPNTZy5b8UdmygyPN7sTt/w=;
        b=xC2B/HzrD19zDHzqAG1BLUl041dnIIGmAh9LGQjDPDwTUDfeVdpzEuwuod3EAM+NOR
         YLVDe2syjLC9vLNdAacJ0rsGOjRUlqAD+QVQ/PZQmwkDGu29jK4NI5OIZdd1YrG1oWIr
         4nCNwRUvIuM8GjZa9lDHICk4jGRU169AIhtdA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id:sender;
        b=Sfa+wBH6rQnMuPdT0tqg2IKvwpPLDiwTzSILkiJ5vJo4eDH+KbqQJlYRHcoCrSj+tE
         DSoQnCFFv9mtIeRVE/ryHyc0vde3bHtmzBjv/Pe0EWoKr6lC1SGm0KF6Kjx01ybUZEij
         MPCTAc9IRJbDw/55cM+kXbuze1c1EJyzqOjS8=
Received: by 10.86.94.11 with SMTP id r11mr2144157fgb.11.1225023872072;
        Sun, 26 Oct 2008 05:24:32 -0700 (PDT)
Received: from ?192.168.1.24? (90.130.195-77.rev.gaoland.net [77.195.130.90])
        by mx.google.com with ESMTPS id 4sm4822263fgg.4.2008.10.26.05.24.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Oct 2008 05:24:31 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH/RFC v1 00/12] Support for Broadcom 63xx SOCs
Date:	Sun, 26 Oct 2008 13:24:17 +0100
User-Agent: KMail/1.9.9
Cc:	Maxime Bizon <mbizon@freebox.fr>, netdev@vger.kernel.org,
	afleming@freescale.com, jgarzik@pobox.com,
	linux-usb@vger.kernel.org, dbrownell@users.sourceforge.net,
	linux-pcmcia@lists.infradead.org, linux-serial@vger.kernel.org,
	linux-mips@linux-mips.org
References: <1224382022-24173-1-git-send-email-mbizon@freebox.fr> <20081026112601.GA9364@linux-mips.org>
In-Reply-To: <20081026112601.GA9364@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200810261324.18288.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20973
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hey Ralf,

Le Sunday 26 October 2008 12:26:01 Ralf Baechle, vous avez écrit :
> As agreed earlier I've setup a git tree on linux-mips.org at
> /pub/scm/linux-bcm63xx.git which also is visible on.
> http://www.linux-mips.org/git.

Thank you very much ! The repository description needs fixing though 
(currently: description  Working Repository for integration of Routerboard 
532 patches.)
