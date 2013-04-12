Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Apr 2013 19:46:18 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:56627 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835071Ab3DLRqSAWNM2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 12 Apr 2013 19:46:18 +0200
Message-ID: <51684862.5000306@phrozen.org>
Date:   Fri, 12 Apr 2013 19:46:10 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Gabor Juhos <juhosg@openwrt.org>
CC:     John Crispin <blogic@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: move mips_{set,get}_machine_name() to a more generic
 place
References: <1365662099-3981-1-git-send-email-blogic@openwrt.org> <516845AB.8080109@openwrt.org>
In-Reply-To: <516845AB.8080109@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36120
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

Am 4/12/13 7:34 PM, schrieb Gabor Juhos:
> Any specific reason why you are using snprintf? If someone would call this with
> format characters in the 'name' that would cause weird things.
strncpy makes more sense indeed. the code i copied used strdup, which 
failed as memory was not available at the time the code ran
