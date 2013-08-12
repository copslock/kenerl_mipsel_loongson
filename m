Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Aug 2013 17:59:53 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:34300 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822344Ab3HLP7t1ifwH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 12 Aug 2013 17:59:49 +0200
Message-ID: <52090650.3000309@imgtec.com>
Date:   Mon, 12 Aug 2013 16:59:12 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Gabor Juhos <juhosg@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        "John Crispin" <blogic@openwrt.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH] MIPS: add driver for the built-in PCI controller of the
 RT3883 SoC
References: <1376064212-28415-1-git-send-email-juhosg@openwrt.org>
In-Reply-To: <1376064212-28415-1-git-send-email-juhosg@openwrt.org>
X-Enigmail-Version: 1.5.2
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.65]
X-SEF-Processed: 7_3_0_01192__2013_08_12_16_59_43
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37529
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

On 09/08/13 17:03, Gabor Juhos wrote:
> +   - status: either "disabled" or "okay"

Is this really a required property? If it's using the generic code for
it then I think it will be treated as "okay" if omitted. In any case I
don't think this property is normally documented in these bindings docs
(I couldn't find any other instances of it).

Cheers
James
