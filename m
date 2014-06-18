Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jun 2014 13:49:51 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:58029 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6819446AbaFRLtuD8YUd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Jun 2014 13:49:50 +0200
Message-ID: <53A17CD5.2060504@phrozen.org>
Date:   Wed, 18 Jun 2014 13:49:41 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     linux-mips@linux-mips.org, ryazanov.s.a@gmail.com
Subject: Re: Introducing Atheros AR231x/AR531x WiSoC support
References: <CAHNKnsSMvc+VeKumoDY5doR4YDhZ+3ezgY903uHnFH7BGQ+XRQ@mail.gmail.com>
In-Reply-To: <CAHNKnsSMvc+VeKumoDY5doR4YDhZ+3ezgY903uHnFH7BGQ+XRQ@mail.gmail.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40624
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



On 18/06/2014 13:46, Sergey Ryazanov wrote:
> Hello,
> 
> I plan to send several patches for upstream merging, that
> introduce support for Atheros AR231x/AR531x WiSoCs. This code
> developed and extensively tested in OpenWRT project. And I need
> some help.
> 
> I need to know what is the preferred way to split code on to
> separate patches suitable for review and merging? Some kind of
> howto or article would be great. Could you recomend something?
> Should I send a series as RFC first?
> 

Hi Sergey,

is the code already in a cleaned up state ? are you just missing the
bit where you split it up into patches or is there still dev work that
needs to be done beyond the actual submission process ?

is your code already available somewhere or do you plan to pusht he
owrt support upstream as is ?

	John
