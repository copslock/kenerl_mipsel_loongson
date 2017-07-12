Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Jul 2017 22:45:55 +0200 (CEST)
Received: from nbd.name ([IPv6:2a01:4f8:131:30e2::2]:39013 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994849AbdGLUpsINNMC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 12 Jul 2017 22:45:48 +0200
Subject: Re: mainlining ar9344
To:     Oleksij Rempel <linux@rempel-privat.de>,
        Alban Bedel <albeu@free.fr>, linux-mips@linux-mips.org,
        Antony Pavlov <antonynpavlov@gmail.com>,
        Felix Fietkau <nbd@openwrt.org>
References: <94279215-a561-58ec-db4b-94dfdd19f342@rempel-privat.de>
From:   John Crispin <john@phrozen.org>
Message-ID: <29150da7-6d77-2a12-a42b-44f87e1911f2@phrozen.org>
Date:   Wed, 12 Jul 2017 22:45:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <94279215-a561-58ec-db4b-94dfdd19f342@rempel-privat.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59100
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



On 11/07/17 22:40, Oleksij Rempel wrote:
> Hallo all,
>
> I have a bunch of ar9344 based APs and would like to spend some free
> time to make it work with mainline kernel (devicetree). Is it a good
> thing to do? Any one working on it?
>
Hi Oleksij,

sounds like a good plan. ath79 needs some more love. let us know if you 
run into any problems.

     John
