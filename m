Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Jan 2015 17:16:50 +0100 (CET)
Received: from bh-25.webhostbox.net ([208.91.199.152]:36564 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011138AbbAKQQtOxuKZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Jan 2015 17:16:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Subject:CC:To:MIME-Version:From:Date:Message-ID; bh=3mL3gtpnfOJI2a5iMiXdmMwNEySY4B0axMea1WiCAqg=;
        b=RV7wjm2zNlNi3cndGh6qM+LR1uwlb4wIRurM6XGDsbnRCWD3pXMr8H9Nr+2LsCPqZYJkJfMs8YtbNBKRsDsnvSF6+cmD57q/jA2cyj3ogqMNJTcpE96R1suuQ6B9QPCFBjaSeuyvVAMasasPKwYZr64lOX1GVNXubZ8EVN9Qpaw=;
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1YALBz-0049pP-N2
        for linux-mips@linux-mips.org; Sun, 11 Jan 2015 16:16:43 +0000
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:57141 helo=server.roeck-us.net)
        by bh-25.webhostbox.net with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
        (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1YALBw-0049fZ-Bo; Sun, 11 Jan 2015 16:16:40 +0000
Message-ID: <54B2A1E5.9030500@roeck-us.net>
Date:   Sun, 11 Jan 2015 08:16:37 -0800
From:   Guenter Roeck <linux@roeck-us.net>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Maarten ter Huurne <maarten@treewalker.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Paul Burton <paul.burton@imgtec.com>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 3/3] MIPS: jz4740: Move reset code to the watchdog driver
References: <1420914550-18335-1-git-send-email-lars@metafoo.de> <1420914550-18335-3-git-send-email-lars@metafoo.de> <54B1CF4B.3070503@roeck-us.net> <1766434.QjfqQROysC@hyperion> <54B24566.5010109@metafoo.de>
In-Reply-To: <54B24566.5010109@metafoo.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated_sender: linux@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-CTCH-PVer: 0000001
X-CTCH-Spam: Unknown
X-CTCH-VOD: Unknown
X-CTCH-Flags: 0
X-CTCH-RefID: str=0001.0A020202.54B2A1EB.0041,ss=1,re=0.001,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-Score: 0.001
X-CTCH-ScoreCust: 0.000
X-CTCH-Rules: C_4847,
X-CTCH-SenderID: linux@roeck-us.net
X-CTCH-SenderID-Flags: 0
X-CTCH-SenderID-TotalMessages: 12
X-CTCH-SenderID-TotalSpam: 0
X-CTCH-SenderID-TotalSuspected: 0
X-CTCH-SenderID-TotalConfirmed: 0
X-CTCH-SenderID-TotalBulk: 0
X-CTCH-SenderID-TotalVirus: 0
X-CTCH-SenderID-TotalRecipients: 0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: mailgid no entry from get_relayhosts_entry
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45071
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On 01/11/2015 01:41 AM, Lars-Peter Clausen wrote:
> On 01/11/2015 02:43 AM, Maarten ter Huurne wrote:
>> On Saturday 10 January 2015 17:18:03 Guenter Roeck wrote:
>>> On 01/10/2015 10:29 AM, Lars-Peter Clausen wrote:
>>>> @@ -186,9 +208,20 @@ static int jz4740_wdt_probe(struct platform_device
>>>> *pdev)>
>>>>        if (ret < 0)
>>>>            goto err_disable_clk;
>>>>
>>>> +    drvdata->restart_handler.notifier_call = jz4740_wdt_restart;
>>>> +    drvdata->restart_handler.priority = 128;
>>>> +    ret = register_restart_handler(&drvdata->restart_handler);
>>>> +    if (ret) {
>>>> +        dev_err(&pdev->dev, "cannot register restart handler, %d\n",
>>>> +            ret);
>>>> +        goto err_unregister_watchdog;
>>>
>>> Are you sure you want to abort in this case ?
>>> After all, the watchdog would still work.
>>
>> That raises a similar question: what about the opposite case, where the
>> watchdog registration fails? If the resource acquisition part of the probe
>> fails, neither the watchdog nor the restart functionality is going to work,
>> but if the call to watchdog_register_device() fails, the restart handler
>> would still work.
>
> I think this is fine, if either the watchdog or the restart handler registration fail then the system is probably already in a rather unusable state.
>
> But that got me thinking, maybe instead of having each watchdog driver register and implement its own restart handler we should maybe add this as a functionality to the watchdog framework. Something along the lines off.
>
> watchdog_set_timeout(wdt, wdt->min_timeout);
> watchdog_start(wdt);
> mdelay(wdt->min_timeout * 2000);
>

Agreed, something like that might be useful as fallback mechanism.

Guenter
