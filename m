Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Aug 2013 16:50:29 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:54292 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822956Ab3HPOu0hiLCF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 16 Aug 2013 16:50:26 +0200
Message-ID: <520E3A7E.7010507@phrozen.org>
Date:   Fri, 16 Aug 2013 16:43:10 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        linux-mips@linux-mips.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v2 2/2] gpio MIPS/OCTEON: Add a driver for OCTEON's on-chip
 GPIO pins.
References: <1375133350-18828-1-git-send-email-ddaney.cavm@gmail.com>        <1375133350-18828-3-git-send-email-ddaney.cavm@gmail.com> <CACRpkdaM=hqwHhNxCLCEZudRNYsyW-bZMXzZyvuW4qs2fGaREw@mail.gmail.com>
In-Reply-To: <CACRpkdaM=hqwHhNxCLCEZudRNYsyW-bZMXzZyvuW4qs2fGaREw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37575
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

On 16/08/13 15:16, Linus Walleij wrote:
> I guess you will merge both patches through the MIPS arch
> tree?

Hi Linus,

sure, we can take them via the MIPS tree

	John
