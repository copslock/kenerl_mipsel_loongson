Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Nov 2011 19:39:47 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:33006 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904611Ab1KXSjl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 24 Nov 2011 19:39:41 +0100
X-Virus-Scanned: at arrakis.dune.hu
Received: from [192.168.254.129] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 1AF2823C009A;
        Thu, 24 Nov 2011 19:39:39 +0100 (CET)
Message-ID: <4ECE8F6B.1060203@openwrt.org>
Date:   Thu, 24 Nov 2011 19:39:39 +0100
From:   Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To:     =?UTF-8?B?UmVuw6kgQm9sbGRvcmY=?= <xsecute@googlemail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Imre Kaloz <kaloz@openwrt.org>
Subject: Re: [PATCH 00/12] MIPS: ath79: AR724X PCI fixes and AR71XX PCI support
References: <1322003670-8797-1-git-send-email-juhosg@openwrt.org> <CAEWqx5-HNNy-9BhYi=nnp3Q=vGQnq1hfH50env5W73ux2UiZXw@mail.gmail.com> <4ECCFE72.6090300@openwrt.org> <CAEWqx5_hgSH0FoWJPL0JDrVXGTWFCV0-FH9hXPMTxbG3A1pScQ@mail.gmail.com> <CAEWqx5_emEPp1HzK=SwOUJnJp5uFhco1asEQjuucdEV4rTQCdg@mail.gmail.com> <4ECD5B06.10204@openwrt.org> <CAEWqx5-deTQLVu=1S9XjKTeq+=O3OE-EXJsXugZAeKYFFzjo-w@mail.gmail.com> <4ECE5D8E.3030504@openwrt.org> <CAEWqx59_YvRfqKxhTYAxrCh=W+UV89V5ibMnBQpC+2i-Ed08Kg@mail.gmail.com>
In-Reply-To: <CAEWqx59_YvRfqKxhTYAxrCh=W+UV89V5ibMnBQpC+2i-Ed08Kg@mail.gmail.com>
X-Enigmail-Version: 1.3.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 31977
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 21031

2011.11.24. 16:54 keltezéssel, René Bolldorf írta:
> 2011/11/24 Gabor Juhos <juhosg@openwrt.org>:
>> Hi René,
>>
>>> Sorry Gabor for the following patch, but it seems your patchset was
>>> against a other tree?
>>
>> Both of my patch sets was based on the 'mips-for-linux-next' branch of Ralf's
>> 'upstream-sfr' tree:
>>
>> git://git.linux-mips.org/pub/scm/ralf/upstream-sfr.git
>>
>>> Because of the many failures I rebase'ed against 09521577ca7718b6c of the
>>> linus tree and written anything from scratch.
>>
>> That was waste of time. The ath79 platform got a pile of changes recently, and
>> those changes are not yet available in Linus' tree. If you were unsure about the
>> tree, you should have asked earlier.
>>
> 
> Alright. I don't play with all trees now.

Why if not indiscreet?

> I wait for the next merge.

If you mean Linus' tree, the new codes will not be merged into that before the
release of 3.2. You would have to wait for a few weeks probably.

-Gabor
