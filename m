Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Nov 2016 14:51:08 +0100 (CET)
Received: from mout.kundenserver.de ([217.72.192.74]:49905 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990508AbcKQNvBLmGno (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Nov 2016 14:51:01 +0100
Received: from wuerfel.localnet ([78.43.21.235]) by mrelayeu.kundenserver.de
 (mreue103 [212.227.15.145]) with ESMTPSA (Nemesis) id
 0MPIxM-1cBknB2Cf2-004Oyt; Thu, 17 Nov 2016 14:50:17 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH] of: base: add support to get machine model name
Date:   Thu, 17 Nov 2016 14:50:13 +0100
Message-ID: <3670336.mMHByOpDl4@wuerfel>
User-Agent: KMail/5.1.3 (Linux/4.4.0-34-generic; KDE/5.18.0; x86_64; ; )
In-Reply-To: <1479383450-19183-1-git-send-email-sudeep.holla@arm.com>
References: <1479383450-19183-1-git-send-email-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:vRqAJd4pS44qtntU9Xn92X2FfQ1GLSh7L23rgOo1J+9xYyQCLTI
 MCcjFrti8ovN//AlEj2zmtn/kOndvCld4RCm0/eqL8oLHFvXyXXm3yr43u+/sROTm3C9fck
 i0XxWdTeCZLIPSGuO677T3eyqQnmJHKUw3obiNO9mhpiAQ2Jnhx7uYrwXNRDm60qwVsHGEE
 qdW9LVYZo+5WPXDyP3zcw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vMJE0KzVURo=:gzk5N2sDEFi6jSE4fztT9F
 daW9kk3zbXdKfMrXgomMf/XFAWO0jaajWT7Al9t2f0V3mM/m0li3aVOXxeZn8ohBKpuvD5EDI
 u6mRvSCj4s39n02jddxmDLqi+h48mdaqhU+4LtA8nla765HTpIYhAvaN3VsPmOno9hnmF5iJA
 FWBn5DiotlRJu1m9qn87AumHNQzt+4r9x6JXKNUhIJW39uK7O9InAme2KzZwPmQZpFQH/Kfgu
 +2zKwpPebpapIQKMQ7YH6j7S2TiokFbbVARs1+2ztZhVAOc23YOtUhduMy89AoV9G7JMc0zXv
 bP4SzA9RDdcqB9cv+JMjjQAgkd0yEO78ps7qc55YDaPxJi+8tnB5L/T/0LZK6myh6EEwrTYbe
 uYjb/397LrBRJF5ngHGxj0UoGF1Su3RS5+lhf0YKY2XW0+VF8/9xj16Zr7GBSLN7DrkUjRtnp
 H3OZoZvqfiBb29jp8NZIDn1p0Rvk4JNCMCrMtYuOK6mc9VN+j+8gk40uFuKXquXBsJjEZT07S
 4jz6i8VhDQWiXdIfYlzb3X8qcGHHozF2j7eVMSheNHg5SZnGBtlUDpX6YbfJS5MZ4qTM67sbZ
 7g73tYQ4llmOJEo8aSEa3zWYJ2emTbZ9z92U5LerNAGDzapvMbDbweWj9HpElfNl0HvMpcqT/
 MoGyesce/KX7fdmpzNnJAaXM1qIP3ln/idkjbzEVSnLVeJKYpPzHgNxBP61ZmL5ns9awRucd2
 KE6RS/K0LEkITYai
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55827
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

On Thursday, November 17, 2016 11:50:50 AM CET Sudeep Holla wrote:
> Currently platforms/drivers needing to get the machine model name are
> replicating the same snippet of code. In some case, the OF reference
> counting is either missing or incorrect.
> 
> This patch adds support to read the machine model name either using
> the "model" or the "compatible" property in the device tree root node.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

I like the idea. One small comment:

> +int of_machine_get_model_name(const char **model)
> +{
> +	int error;
> +	struct device_node *root;
> +
> +	root = of_find_node_by_path("/");
> +	if (!root)
> +		return -EINVAL;

The global of_root variable points ot this already, and is defined
in the same file, so I think we can just skip the lookup.

	Arnd
