Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Feb 2016 23:15:36 +0100 (CET)
Received: from smtp3-g21.free.fr ([212.27.42.3]:29957 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012167AbcBIWPfACXWL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 9 Feb 2016 23:15:35 +0100
Received: from tock (unknown [80.171.101.200])
        (Authenticated sender: albeu)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id EC1A4A626C;
        Tue,  9 Feb 2016 23:13:07 +0100 (CET)
Date:   Tue, 9 Feb 2016 23:15:20 +0100
From:   Alban <albeu@free.fr>
To:     Antony Pavlov <antonynpavlov@gmail.com>
Cc:     Aban Bedel <albeu@free.fr>, linux-mips@linux-mips.org,
        Marek Vasut <marex@denx.de>, Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v5 07/15] usb: ehci: add vbus-gpio parameter
Message-ID: <20160209231520.727b6ccd@tock>
In-Reply-To: <1455005641-7079-8-git-send-email-antonynpavlov@gmail.com>
References: <1455005641-7079-1-git-send-email-antonynpavlov@gmail.com>
        <1455005641-7079-8-git-send-email-antonynpavlov@gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51930
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

On Tue,  9 Feb 2016 11:13:53 +0300
Antony Pavlov <antonynpavlov@gmail.com> wrote:

> This patch retrieves and configures the vbus control gpio via
> the device tree.

Wouldn't using a regulator be better than hard coding the GPIO case?

Alban
