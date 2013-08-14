Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Aug 2013 10:30:26 +0200 (CEST)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:43909 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6817128Ab3HNIaXtTHz0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Aug 2013 10:30:23 +0200
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 73BF7521C6E;
        Wed, 14 Aug 2013 10:30:17 +0200 (CEST)
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sYAHeHFwAuQy; Wed, 14 Aug 2013 10:30:17 +0200 (CEST)
Received: from [192.168.254.50] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 1F92D521C38;
        Wed, 14 Aug 2013 10:30:17 +0200 (CEST)
Message-ID: <520B4026.6060908@openwrt.org>
Date:   Wed, 14 Aug 2013 10:30:30 +0200
From:   Gabor Juhos <juhosg@openwrt.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        John Crispin <blogic@openwrt.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH] MIPS: add driver for the built-in PCI controller of the
 RT3883 SoC
References: <1376064212-28415-1-git-send-email-juhosg@openwrt.org> <52090650.3000309@imgtec.com>
In-Reply-To: <52090650.3000309@imgtec.com>
X-Enigmail-Version: 1.5.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37540
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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

2013.08.12. 17:59 keltezéssel, James Hogan írta:
> On 09/08/13 17:03, Gabor Juhos wrote:
>> +   - status: either "disabled" or "okay"
> 
> Is this really a required property? If it's using the generic code for
> it then I think it will be treated as "okay" if omitted. 

You are right, it is optional. The driver explicitly does not checks the
presence of the property. However instead of removing this part from the doc, I
would change the text to indicate that the property is optional.

> In any case I don't think this property is normally documented in these
> bindings docs (I couldn't find any other instances of it).

It is documented in mvebu-pci.txt as well, at least in 3.11-rc5.

-Gabor
