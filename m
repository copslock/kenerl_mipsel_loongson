Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Nov 2013 18:11:40 +0100 (CET)
Received: from prod-mail-xrelay07.akamai.com ([72.246.2.115]:62754 "EHLO
        prod-mail-xrelay07.akamai.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861162Ab3KSRLfuZgRO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Nov 2013 18:11:35 +0100
Received: from prod-mail-xrelay07.akamai.com (localhost.localdomain [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id 9F8BA473B8;
        Tue, 19 Nov 2013 17:11:29 +0000 (GMT)
Received: from prod-mail-relay02.akamai.com (prod-mail-relay02.akamai.com [172.17.50.21])
        by prod-mail-xrelay07.akamai.com (Postfix) with ESMTP id 9B00D473BE;
        Tue, 19 Nov 2013 17:11:29 +0000 (GMT)
Received: from [172.28.13.159] (bos-lp77o.kendall.corp.akamai.com [172.28.13.159])
        by prod-mail-relay02.akamai.com (Postfix) with ESMTP id 7C3BFFE074;
        Tue, 19 Nov 2013 17:11:29 +0000 (GMT)
Message-ID: <528B9BC1.7090402@akamai.com>
Date:   Tue, 19 Nov 2013 12:11:29 -0500
From:   Jason Baron <jbaron@akamai.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130330 Thunderbird/17.0.5
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     "mingo@kernel.org" <mingo@kernel.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Florian Fainelli <florian@openwrt.org>,
        Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>,
        Jayachandran C <jchandra@broadcom.com>,
        Ganesan Ramalingam <ganesanr@broadcom.com>
Subject: Re: [PATCH v2] panic: Make panic_timeout configurable
References: <20131118210436.233B5202A@prod-mail-relay06.akamai.com> <20131119090211.GN10382@linux-mips.org>
In-Reply-To: <20131119090211.GN10382@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <jbaron@akamai.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38548
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbaron@akamai.com
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

On 11/19/2013 04:02 AM, Ralf Baechle wrote:
> On Mon, Nov 18, 2013 at 09:04:36PM +0000, Jason Baron wrote:
> 
>> The panic_timeout value can be set via the command line option 'panic=x', or via
>> /proc/sys/kernel/panic, however that is not sufficient when the panic occurs
>> before we are able to set up these values. Thus, add a CONFIG_PANIC_TIMEOUT
>> so that we can set the desired value from the .config.
>>
>> The default panic_timeout value continues to be 0 - wait forever, except for
>> powerpc and mips, which have been defaulted to 180 and 5 respectively. This
>> is in keeping with the fact that these arches already set panic_timeout in
>> their arch init code. However, I found three exceptions- two in mips and one in
>> powerpc where the settings didn't match these default values. In those cases, I
>> left the arch code so it continues to override, in case the user has not changed
>> from the default. It would nice if these arches had one default value, or if we
>> could determine the correct setting at compile-time.
> 
> It's more complicated - MIPS was using the global default with five MIPS
> platforms overriding the default.
> 
> I propose to kill these overrides for sanity unless somebody comes up
> with a good argument.  Patch below.
> 

And so have the mips default be 0? IE drop the arch/mips/Kconfig bits from
the patch I posted? (Which could of course be configured to a non-zero value
by the user, if desired.)

Thanks,

-Jason
