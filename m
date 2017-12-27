Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Dec 2017 13:46:23 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:38490 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990434AbdL0MqNPC666 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Dec 2017 13:46:13 +0100
Received: from localhost (LFbn-1-12258-90.w90-92.abo.wanadoo.fr [90.92.71.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0482B98C;
        Wed, 27 Dec 2017 12:46:06 +0000 (UTC)
Date:   Wed, 27 Dec 2017 13:46:09 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Zubair.Kakakhel@imgtec.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Harvey Hunt <harvey.hunt@imgtec.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] dts: Probe efuse for CI20
Message-ID: <20171227124609.GA3373@kroah.com>
References: <20171227122722.5219-1-malat@debian.org>
 <20171227122722.5219-3-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171227122722.5219-3-malat@debian.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61631
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

On Wed, Dec 27, 2017 at 01:27:02PM +0100, Mathieu Malaterre wrote:
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

I know i can't take patches without any changelog text at all, and
really, you shouldn't ever create such a thing :)

thanks,

greg k-h
