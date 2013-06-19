Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jun 2013 00:42:35 +0200 (CEST)
Received: from moutng.kundenserver.de ([212.227.17.8]:54582 "EHLO
        moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835001Ab3FSWmeL1hNx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Jun 2013 00:42:34 +0200
Received: from klappe2.localnet (HSI-KBW-095-208-002-043.hsi5.kabel-badenwuerttemberg.de [95.208.2.43])
        by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
        id 0M0oNX-1U1sYs1MMh-00v9TD; Thu, 20 Jun 2013 00:42:21 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     David Daney <ddaney.cavm@gmail.com>
Subject: Re: [PATCH v2 2/4] tty/8250_dw: Add support for OCTEON UARTS.
Date:   Thu, 20 Jun 2013 00:42:18 +0200
User-Agent: KMail/1.12.2 (Linux/3.8.0-22-generic; KDE/4.3.2; x86_64; ; )
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Jamie Iles <jamie@jamieiles.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <1371677849-23912-1-git-send-email-ddaney.cavm@gmail.com> <1371677849-23912-3-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1371677849-23912-3-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201306200042.19064.arnd@arndb.de>
X-Provags-ID: V02:K0:j4bdPI5/1JWHBI4KwaAUZ/ht14f8HAxX9Jz1RYslcqw
 7FYECc37pjxHU7Jta9+7srUVNmbzguNiyD+ntaSBcgH0EU3Ly+
 kHGylqRzqZOTalmNxrU/oEbZ/5KZW40bUopxNu6XrDucT1JjdI
 BTxAYWcglgZtpCadWnyKz8+s+Wv1VXH/Hym0moVfzeBWHVYI+/
 DSPE/UiHtqUPIckLee8q17TfREYNNRJdzFnbyZmr+5W1t1RRHU
 vb23fFcDinmwIHSzFrT+3gEXOPg0mU0sGMv6ulsum6qmZKteAM
 33U/wlo5GAJER5eDiCy7pkuD6Z/MOJuPtO/kgb2kiK0zdd8QQE
 Pk1uSO8XvDNcGUro3o9U=
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37032
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Wednesday 19 June 2013, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> A few differences needed by OCTEON:
> 
> o These are DWC UARTS, but have USR at a different offset.
> 
> o Internal SoC buses require reading back from registers to maintain
>   write ordering.
> 
> o 8250 on OCTEON appears with 64-bit wide registers, so when using
>   readb/writeb in big endian mode we have to adjust the membase to hit
>   the proper part of the register.
> 
> o No UCV register, so we hard code some properties.
> 
> Because OCTEON doesn't have a UCV register, I change where
> dw8250_setup_port(), which reads the UCV, is called by pushing it in
> to the OF and ACPI probe functions, and move unchanged
> dw8250_setup_port() earlier in the file.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
