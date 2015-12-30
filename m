Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Dec 2015 14:53:46 +0100 (CET)
Received: from smtp1-g21.free.fr ([212.27.42.1]:45031 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007593AbbL3NxolrIOI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 30 Dec 2015 14:53:44 +0100
Received: from tock (unknown [78.54.22.109])
        (Authenticated sender: albeu)
        by smtp1-g21.free.fr (Postfix) with ESMTPSA id 2E30994018D;
        Wed, 30 Dec 2015 14:53:00 +0100 (CET)
Date:   Wed, 30 Dec 2015 14:53:29 +0100
From:   Alban <albeu@free.fr>
Cc:     Aban Bedel <albeu@free.fr>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Alexander Couzens <lynxis@fe80.eu>,
        Joel Porquet <joel@porquet.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] MIPS: ath79: irq: Move the MISC driver to
 drivers/irqchip
Message-ID: <20151230145329.34469270@tock>
In-Reply-To: <1447788896-15553-5-git-send-email-albeu@free.fr>
References: <1447788896-15553-1-git-send-email-albeu@free.fr>
        <1447788896-15553-5-git-send-email-albeu@free.fr>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50773
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

On Tue, 17 Nov 2015 20:34:54 +0100
Alban Bedel <albeu@free.fr> wrote:

> The driver stays the same but the initialization changes a bit.
> For OF boards we now get the memory map from the OF node and use
> a linear mapping instead of the legacy mapping. For legacy boards
> we still use a legacy mapping and just pass down all the parameters
> from the board init code.
> 
> Signed-off-by: Alban Bedel <albeu@free.fr>

Most of this series has been applied to the MIPS tree, but patch 4
and 6 are still waiting for an ACK from the irqchip maintainers.
Is there any problem with those patches?

Alban
