Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Aug 2007 21:34:42 +0100 (BST)
Received: from mailgate01.ni.ber.native-instruments.com ([85.158.2.40]:33218
	"EHLO mailgate01.ni.ber.native-instruments.com") by ftp.linux-mips.org
	with ESMTP id S20021997AbXHFUek (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 6 Aug 2007 21:34:40 +0100
Received: (qmail 7151 invoked from network); 6 Aug 2007 20:33:32 -0000
Received: from unknown (HELO florian-schirmers-computer.local) (florian.schirmer@[88.73.95.215])
          (envelope-sender <jolt@tuxbox.org>)
          by 192.168.2.11 (qmail-ldap-1.03) with SMTP
          for <aurelien@aurel32.net>; 6 Aug 2007 20:33:32 -0000
Message-ID: <46B7859D.7040206@tuxbox.org>
Date:	Mon, 06 Aug 2007 22:33:33 +0200
From:	Florian Schirmer <jolt@tuxbox.org>
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
MIME-Version: 1.0
To:	Aurelien Jarno <aurelien@aurel32.net>
CC:	Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org,
	Michael Buesch <mb@bu3sch.de>,
	Waldemar Brodkorb <wbx@openwrt.org>,
	Felix Fietkau <nbd@openwrt.org>
Subject: Re: [PATCH -mm 4/4] MIPS: Add BCM947xx to Makefile
References: <20070806151002.GI24308@hall.aurel32.net>
In-Reply-To: <20070806151002.GI24308@hall.aurel32.net>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jolt@tuxbox.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16095
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jolt@tuxbox.org
Precedence: bulk
X-list: linux-mips

Hi,

Aurelien Jarno wrote:
> The patch below against 2.6.23-rc1-mm2 adds BCM947xx to 
> arch/mips/Makefile.
>
> Cc: Michael Buesch <mb@bu3sch.de>
> Cc: Waldemar Brodkorb <wbx@openwrt.org>
> Cc: Felix Fietkau <nbd@openwrt.org>
> Cc: Florian Schirmer <jolt@tuxbox.org>
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
>
>   

Looks good!

Acked-by: Florian Schirmer <jolt@tuxbox.org>

Best,
  Florian



> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -549,6 +549,12 @@
>  load-$(CONFIG_SIBYTE_BIGSUR)	:= 0xffffffff80100000
>  
>  #
> +# Broadcom BCM947XX boards
> +#
> +core-$(CONFIG_BCM947XX)		+= arch/mips/bcm947xx/
> +load-$(CONFIG_BCM947XX)		:= 0xffffffff80001000
> +
> +#
>  # SNI RM
>  #
>  core-$(CONFIG_SNI_RM)		+= arch/mips/sni/
>
>   
