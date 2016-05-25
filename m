Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 May 2016 11:50:40 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:35209 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27027714AbcEYJugHd58o (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 May 2016 11:50:36 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <anna-maria@linutronix.de>)
        id 1b5VSU-000196-Vv; Wed, 25 May 2016 11:50:35 +0200
Date:   Wed, 25 May 2016 11:51:20 +0200 (CEST)
From:   Anna-Maria Gleixner <anna-maria@linutronix.de>
To:     David Daney <ddaney.cavm@gmail.com>
cc:     linux-kernel@vger.kernel.org, rt@linutronix.de,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Add missing FROZEN hotplug notifier transitions
In-Reply-To: <57449A28.3020901@gmail.com>
Message-ID: <alpine.DEB.2.11.1605251149140.2902@hypnos.tec.linutronix.de>
References: <1464095327-55194-1-git-send-email-anna-maria@linutronix.de> <57449A28.3020901@gmail.com>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001,URIBL_BLOCKED=0.001
Return-Path: <anna-maria@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53652
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anna-maria@linutronix.de
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

On Tue, 24 May 2016, David Daney wrote:

> On 05/24/2016 06:08 AM, Anna-Maria Gleixner wrote:
> > The corresponding FROZEN hotplug notifier transitions used on
> > suspend/resume are ignored. Therefore the switch case action argument
> > is masked with the frozen hotplug notifier transition mask.
> > 
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: linux-mips@linux-mips.org
> > Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
> 
> This seems sane, and I don't object, but can you tell us how this was tested?

It is compile tested only due to lack of hardware.

Anna-Maria
