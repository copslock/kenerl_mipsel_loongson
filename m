Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jan 2005 09:12:31 +0000 (GMT)
Received: from smtp.seznam.cz ([IPv6:::ffff:212.80.76.43]:54702 "HELO
	smtp.seznam.cz") by linux-mips.org with SMTP id <S8225229AbVAGJMZ>;
	Fri, 7 Jan 2005 09:12:25 +0000
Received: (qmail 1002 invoked from network); 7 Jan 2005 09:12:19 -0000
Received: from unknown (HELO orphique) (Ladislav.Michl@62.77.73.201)
  by smtp.seznam.cz with SMTP; 7 Jan 2005 09:12:19 -0000
Received: from ladis by orphique with local (Exim 3.36 #1 (Debian))
	id 1CmqAN-00012z-00; Fri, 07 Jan 2005 10:12:19 +0100
Date: Fri, 7 Jan 2005 10:12:19 +0100
To: Greg KH <greg@kroah.com>
Cc: "Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com,
	linux-mips@linux-mips.org
Subject: Re: [2.6 patch] 2.6.10-mm2: let I2C_ALGO_SGI depend on MIPS
Message-ID: <20050107091218.GA3715@orphique>
References: <20050106002240.00ac4611.akpm@osdl.org> <20050106181519.GG3096@stusta.de> <20050106192701.GA13955@linux-mips.org> <41DD9313.4030105@total-knowledge.com> <20050106194646.GB5481@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106194646.GB5481@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
From: Ladislav Michl <ladis@linux-mips.org>
Return-Path: <ladis@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6831
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ladis@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 06, 2005 at 11:46:46AM -0800, Greg KH wrote:
> Ok, can someone send me the proper patch then?

Index: drivers/i2c/algos/Kconfig
===================================================================
RCS file: /home/cvs/linux/drivers/i2c/algos/Kconfig,v
retrieving revision 1.3
diff -u -r1.3 Kconfig
--- drivers/i2c/algos/Kconfig	24 Aug 2004 15:10:09 -0000	1.3
+++ drivers/i2c/algos/Kconfig	7 Jan 2005 09:10:10 -0000
@@ -61,7 +61,7 @@
 
 config I2C_ALGO_SGI
 	tristate "I2C SGI interfaces"
-	depends on I2C
+	depends on I2C && (SGI_IP22 || SGI_IP32 || X86_VISWS)
 	help
 	  Supports the SGI interfaces like the ones found on SGI Indy VINO
 	  or SGI O2 MACE.
