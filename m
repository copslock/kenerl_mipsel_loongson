Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jun 2015 23:58:33 +0200 (CEST)
Received: from smtp1-g21.free.fr ([212.27.42.1]:11357 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008437AbbFJV6biUEPo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Jun 2015 23:58:31 +0200
Received: from tock (unknown [78.54.109.140])
        (Authenticated sender: albeu)
        by smtp1-g21.free.fr (Postfix) with ESMTPSA id 9E35A94004B;
        Wed, 10 Jun 2015 23:54:01 +0200 (CEST)
Date:   Wed, 10 Jun 2015 23:58:11 +0200
From:   Alban <albeu@free.fr>
To:     Antony Pavlov <antonynpavlov@gmail.com>
Cc:     Aban Bedel <albeu@free.fr>, linux-mips@linux-mips.org,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Gabor Juhos <juhosg@openwrt.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 12/12] MIPS: Add basic support for the TL-WR1043ND
 version 1
Message-ID: <20150610235811.0b18af9b@tock>
In-Reply-To: <20150608131758.9d76be074998ea3de0e976a4@gmail.com>
References: <1433029955-7346-1-git-send-email-albeu@free.fr>
        <1433031506-7984-5-git-send-email-albeu@free.fr>
        <20150608131758.9d76be074998ea3de0e976a4@gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47925
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

On Mon, 8 Jun 2015 13:17:58 +0300
Antony Pavlov <antonynpavlov@gmail.com> wrote:

> IMHO AR9132 SoC can't work without external oscilator.
> 
> Can we just move basic extosc declaration to SoC dt file
> (ar9132.dtsi)? So board dt file ar9132_tl_wr1043nd_v1.dts will
> contain only oscilator clock frequency value.

I would prefer to keep the split between the files in sync with the
hardware. I understand that most simple board designs use a fixed
oscillator, but that might not always be the case.

Alban
