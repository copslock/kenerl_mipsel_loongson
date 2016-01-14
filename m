Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jan 2016 14:55:58 +0100 (CET)
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:45128 "EHLO
        lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009908AbcANNzzkd8Nc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Jan 2016 14:55:55 +0100
Received: from localhost.localdomain (proxy [81.2.110.250])
        by lxorguk.ukuu.org.uk (8.15.2/8.14.1) with ESMTP id u0EEVruI011406;
        Thu, 14 Jan 2016 14:31:59 GMT
Date:   Thu, 14 Jan 2016 13:55:47 +0000
From:   One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
To:     Joshua Henderson <joshua.henderson@microchip.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <ralf@linux-mips.org>,
        Andrei Pistirica <andrei.pistirica@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, <linux-serial@vger.kernel.org>,
        <linux-api@vger.kernel.org>
Subject: Re: [PATCH v5 10/14] serial: pic32_uart: Add PIC32 UART driver
Message-ID: <20160114135547.3ac6a296@lxorguk.ukuu.org.uk>
In-Reply-To: <1452734299-460-11-git-send-email-joshua.henderson@microchip.com>
References: <1452734299-460-1-git-send-email-joshua.henderson@microchip.com>
        <1452734299-460-11-git-send-email-joshua.henderson@microchip.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.12.0 (GTK+ 2.24.29; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <gnomes@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51120
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gnomes@lxorguk.ukuu.org.uk
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

On Wed, 13 Jan 2016 18:15:43 -0700
Joshua Henderson <joshua.henderson@microchip.com> wrote:

> From: Andrei Pistirica <andrei.pistirica@microchip.com>
> 
> This adds UART and a serial console driver for Microchip PIC32 class
> devices.
> 
> Signed-off-by: Andrei Pistirica <andrei.pistirica@microchip.com>
> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>

Reviewed-by: Alan Cox <alan@linux.intel.com>
