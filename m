Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Apr 2013 15:58:13 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:47598 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822672Ab3DJN6MWLlas (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Apr 2013 15:58:12 +0200
Message-ID: <51656F05.8000606@phrozen.org>
Date:   Wed, 10 Apr 2013 15:54:13 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH 08/18] MIPS: ralink: add RT5350 dtsi file
References: <1365594447-13068-1-git-send-email-blogic@openwrt.org> <1365594447-13068-9-git-send-email-blogic@openwrt.org> <CAOiHx=nJBFj+3coeGhHnLLhVU5ihc7OVC=N6juvfdETrsA+vBQ@mail.gmail.com>
In-Reply-To: <CAOiHx=nJBFj+3coeGhHnLLhVU5ihc7OVC=N6juvfdETrsA+vBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36063
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

On 10/04/13 15:53, Jonas Gorski wrote:
>> +       chosen {
>> >  +               bootargs = "console=ttyS0,57600 init=/init";
> Shouldn't this belong in the individual .dts files instead of the
> .dtsi? Likewise for all the other .dtsi files added by this patchset.
>
>
> Jonas
>
>

the init=/init bit is bogus. all other boards with the exception of 
maybe 2 or 3 use 57600 for console.
