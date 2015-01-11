Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Jan 2015 10:42:05 +0100 (CET)
Received: from smtp-out-127.synserver.de ([212.40.185.127]:1035 "EHLO
        smtp-out-127.synserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009634AbbAKJmDnnnA0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Jan 2015 10:42:03 +0100
Received: (qmail 3453 invoked by uid 0); 11 Jan 2015 09:42:02 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@metafoo.de
X-SynServer-PPID: 3002
Received: from ppp-88-217-3-222.dynamic.mnet-online.de (HELO ?192.168.178.23?) [88.217.3.222]
  by 217.119.54.81 with AES128-SHA encrypted SMTP; 11 Jan 2015 09:42:01 -0000
Message-ID: <54B24566.5010109@metafoo.de>
Date:   Sun, 11 Jan 2015 10:41:58 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.3.0
MIME-Version: 1.0
To:     Maarten ter Huurne <maarten@treewalker.org>,
        Guenter Roeck <linux@roeck-us.net>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Paul Burton <paul.burton@imgtec.com>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 3/3] MIPS: jz4740: Move reset code to the watchdog driver
References: <1420914550-18335-1-git-send-email-lars@metafoo.de> <1420914550-18335-3-git-send-email-lars@metafoo.de> <54B1CF4B.3070503@roeck-us.net> <1766434.QjfqQROysC@hyperion>
In-Reply-To: <1766434.QjfqQROysC@hyperion>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45063
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

On 01/11/2015 02:43 AM, Maarten ter Huurne wrote:
> On Saturday 10 January 2015 17:18:03 Guenter Roeck wrote:
>> On 01/10/2015 10:29 AM, Lars-Peter Clausen wrote:
>>> @@ -186,9 +208,20 @@ static int jz4740_wdt_probe(struct platform_device
>>> *pdev)>
>>>    	if (ret < 0)
>>>    		goto err_disable_clk;
>>>
>>> +	drvdata->restart_handler.notifier_call = jz4740_wdt_restart;
>>> +	drvdata->restart_handler.priority = 128;
>>> +	ret = register_restart_handler(&drvdata->restart_handler);
>>> +	if (ret) {
>>> +		dev_err(&pdev->dev, "cannot register restart handler, %d\n",
>>> +			ret);
>>> +		goto err_unregister_watchdog;
>>
>> Are you sure you want to abort in this case ?
>> After all, the watchdog would still work.
>
> That raises a similar question: what about the opposite case, where the
> watchdog registration fails? If the resource acquisition part of the probe
> fails, neither the watchdog nor the restart functionality is going to work,
> but if the call to watchdog_register_device() fails, the restart handler
> would still work.

I think this is fine, if either the watchdog or the restart handler 
registration fail then the system is probably already in a rather unusable 
state.

But that got me thinking, maybe instead of having each watchdog driver 
register and implement its own restart handler we should maybe add this as a 
functionality to the watchdog framework. Something along the lines off.

watchdog_set_timeout(wdt, wdt->min_timeout);
watchdog_start(wdt);
mdelay(wdt->min_timeout * 2000);

- Lars
