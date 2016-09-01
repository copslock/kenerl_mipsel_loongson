Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Sep 2016 12:57:31 +0200 (CEST)
Received: from www381.your-server.de ([78.46.137.84]:53794 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990519AbcIAK5Y6BQBD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Sep 2016 12:57:24 +0200
Received: from [88.198.220.132] (helo=sslproxy03.your-server.de)
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <lars@metafoo.de>)
        id 1bfPgK-00018v-JM; Thu, 01 Sep 2016 12:57:16 +0200
Received: from [2003:86:2c57:7e00:8200:bff:fe9b:6612]
        by sslproxy03.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-SHA:256)
        (Exim 4.84_2)
        (envelope-from <lars@metafoo.de>)
        id 1bfPgK-0000IF-67; Thu, 01 Sep 2016 12:57:16 +0200
Subject: Re: [Patch v3 07/11] MIPS: Xilfpga: Add DT node for AXI I2C
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        monstr@monstr.eu, ralf@linux-mips.org, tglx@linutronix.de,
        jason@lakedaemon.net, marc.zyngier@arm.com
References: <1472661352-11983-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1472661352-11983-8-git-send-email-Zubair.Kakakhel@imgtec.com>
Cc:     soren.brinkmann@xilinx.com, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, michal.simek@xilinx.com,
        netdev@vger.kernel.org
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <74279d97-beeb-e754-40ad-3bfc8eeba66d@metafoo.de>
Date:   Thu, 1 Sep 2016 12:57:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.1.0
MIME-Version: 1.0
In-Reply-To: <1472661352-11983-8-git-send-email-Zubair.Kakakhel@imgtec.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.99.2/22165/Thu Sep  1 09:24:34 2016)
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54919
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
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

On 08/31/2016 06:35 PM, Zubair Lutfullah Kakakhel wrote:
[..]
> +	    ad7420@4B {
> +		compatible = "adt7420";

"adi,adt7420"

> +		reg = <0x4B>;
> +	    };
> +	} ;
>  };
