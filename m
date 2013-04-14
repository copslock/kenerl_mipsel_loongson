Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Apr 2013 11:49:42 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:40722 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6824803Ab3DNJtgGwAOU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 14 Apr 2013 11:49:36 +0200
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SLIR-lmSOe2S; Sun, 14 Apr 2013 11:48:48 +0200 (CEST)
Received: from [192.168.254.50] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id F3224283E13;
        Sun, 14 Apr 2013 11:48:47 +0200 (CEST)
Message-ID: <516A7BD8.2090505@openwrt.org>
Date:   Sun, 14 Apr 2013 11:50:16 +0200
From:   Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To:     John Crispin <john@phrozen.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH 3/6] DT: MIPS: ralink: extend RT3050 dtsi and dts file
References: <1365843026-11015-1-git-send-email-blogic@openwrt.org> <1365843026-11015-3-git-send-email-blogic@openwrt.org> <5169708C.6040209@cogentembedded.com> <51699CEB.9000806@phrozen.org>
In-Reply-To: <51699CEB.9000806@phrozen.org>
X-Enigmail-Version: 1.5.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36159
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

2013.04.13. 19:59 keltezéssel, John Crispin írta:
> 
>>> * remove nodes for cores whose drivers are not upstream yet
>>
>>    And you call that "extend"? :-)
> 
> 
> ermm yes, lets change it to "clean up"  :)

When you are going to change that, please remove the #{address,size}-cells
properties from the root node in the rt3052_eval.dts file. The rt3050.dtsi file
contains those properties with the same values already.

-Gabor
