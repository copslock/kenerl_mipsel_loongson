Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jun 2014 15:02:59 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:34285 "EHLO nbd.name"
        rhost-flags-OK-FAIL-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6859953AbaFRNCsMcdP7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Jun 2014 15:02:48 +0200
Message-ID: <53A18DEC.3030609@phrozen.org>
Date:   Wed, 18 Jun 2014 15:02:36 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Sergey Ryazanov <ryazanov.s.a@gmail.com>
CC:     linux-mips@linux-mips.org
Subject: Re: Introducing Atheros AR231x/AR531x WiSoC support
References: <CAHNKnsSMvc+VeKumoDY5doR4YDhZ+3ezgY903uHnFH7BGQ+XRQ@mail.gmail.com> <53A17CD5.2060504@phrozen.org> <CAHNKnsS25qSenaXKCTB4URnOMAVvJmbotQz4hv4iukBTMcn0QA@mail.gmail.com>
In-Reply-To: <CAHNKnsS25qSenaXKCTB4URnOMAVvJmbotQz4hv4iukBTMcn0QA@mail.gmail.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40630
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



On 18/06/2014 14:51, Sergey Ryazanov wrote:
>> is your code already available somewhere or do you plan to pusht
>> he
>>> owrt support upstream as is ?
> I does not do any forks, all changes were made as patches that
> were accepted to owrt. Then I plan to rebase the code on to
> linux-mips.git and send upstream.



so these are the patches in question ? ->
https://dev.openwrt.org/browser/trunk/target/linux/atheros/patches-3.10
