Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Feb 2015 21:52:36 +0100 (CET)
Received: from bh-25.webhostbox.net ([208.91.199.152]:42967 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012885AbbBPUwfEslnG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Feb 2015 21:52:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Subject:CC:To:MIME-Version:From:Date:Message-ID; bh=DaQfae6MO/5VtjaGb2bAMrwQr5LV7f77NswZtkD0+xQ=;
        b=InITwdEYZeOOWbqs17Mbzbd+X49Z4naNIo8RSsmJbvsAM/4mPl679IoKP1Dt772baMEf0r487evB/4f7gETkAPoVEf1KcIsQE4z/ra/mj5dgaQ7/TudQ+ZokThRuGwGfbnMLmbFkgXmBTD6C1ooYz3QZ3pH4mEqOoo8HUVeweVs=;
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1YNSeb-003XXA-I5
        for linux-mips@linux-mips.org; Mon, 16 Feb 2015 20:52:29 +0000
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:35343 helo=server.roeck-us.net)
        by bh-25.webhostbox.net with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
        (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1YNSeS-003XMo-Lw; Mon, 16 Feb 2015 20:52:21 +0000
Message-ID: <54E25883.3080704@roeck-us.net>
Date:   Mon, 16 Feb 2015 12:52:19 -0800
From:   Guenter Roeck <linux@roeck-us.net>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        baspeters93@gmail.com
Subject: Re: linux-next: Tree for Feb 16
References: <20120216164144.35e98f5ee8f1b1f545406309@canb.auug.org.au>  <20150216171213.GA2804@roeck-us.net> <20150217073619.4c972211@canb.auug.org.au>
In-Reply-To: <20150217073619.4c972211@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated_sender: linux@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-CTCH-PVer: 0000001
X-CTCH-Spam: Unknown
X-CTCH-VOD: Unknown
X-CTCH-Flags: 0
X-CTCH-RefID: str=0001.0A020201.54E2588D.0173,ss=1,re=0.001,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-Score: 0.001
X-CTCH-ScoreCust: 0.000
X-CTCH-Rules: C_4847,
X-CTCH-SenderID: linux@roeck-us.net
X-CTCH-SenderID-Flags: 0
X-CTCH-SenderID-TotalMessages: 4
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
X-archive-position: 45831
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

On 02/16/2015 12:36 PM, Stephen Rothwell wrote:
> Hi Guenter,
>
> On Mon, 16 Feb 2015 09:12:13 -0800 Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On Thu, Feb 16, 2012 at 04:41:44PM +1100, Stephen Rothwell wrote:
>>>
>>> Changes since 20120215:
>> ---
>> [ Trying again, this time hopefully replying to the correct e-mail.
>>    Sorry for the earlier noise. ]
>
> Did you really mean to reply to a release from 3 years ago?
>

Sigh. No, of course not :-(. I think I am giving up for today.

Guenter
