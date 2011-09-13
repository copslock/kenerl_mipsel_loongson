Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Sep 2011 14:22:30 +0200 (CEST)
Received: from mail1.pearl-online.net ([62.159.194.147]:48836 "EHLO
        mail1.pearl-online.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491101Ab1IMMWX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Sep 2011 14:22:23 +0200
Received: from Mobile0.Peter (109.125.101.165.dynamic.cablesurf.de [109.125.101.165])
        by mail1.pearl-online.net (Postfix) with ESMTPA id E9ACF201E6;
        Tue, 13 Sep 2011 14:22:16 +0200 (CEST)
Received: from Indigo2.Peter (Indigo2.Peter [192.168.1.28])
        by Mobile0.Peter (8.12.6/8.12.6/Sendmail/Linux 2.2.13) with ESMTP id p8DE0Y9e001664;
        Tue, 13 Sep 2011 14:00:34 GMT
Received: from Indigo2.Peter (localhost [127.0.0.1])
        by Indigo2.Peter (8.12.6/8.12.6/Sendmail/Linux 2.6.14-rc2-ip28) with ESMTP id p8DCK0AV005819;
        Tue, 13 Sep 2011 14:20:00 +0200
Received: from localhost (pf@localhost)
        by Indigo2.Peter (8.12.6/8.12.6/Submit) with ESMTP id p8DCK0ne005816;
        Tue, 13 Sep 2011 14:20:00 +0200
X-Authentication-Warning: Indigo2.Peter: pf owned process doing -bs
Date:   Tue, 13 Sep 2011 14:20:00 +0200 (CEST)
From:   peter fuerst <post@pfrst.de>
X-X-Sender: pf@Indigo2.Peter
Reply-To: post@pfrst.de
To:     Sergei Shtylyov <sshtylyov@mvista.com>
cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] Impact video driver for SGI Indigo2
In-Reply-To: <4E6F32AE.3040007@mvista.com>
Message-ID: <Pine.LNX.4.64.1109131410001.5810@Indigo2.Peter>
References: <Pine.LNX.4.64.1109131101530.4143@Indigo2.Peter>
 <4E6F32AE.3040007@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-archive-position: 31063
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: post@pfrst.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 6349



On Tue, 13 Sep 2011, Sergei Shtylyov wrote:

> Date: Tue, 13 Sep 2011 14:38:38 +0400
> From: Sergei Shtylyov <sshtylyov@mvista.com>
> To: post@pfrst.de
> Cc: linux-mips@linux-mips.org
> Subject: Re: [PATCH] Impact video driver for SGI Indigo2
> 
> Hello.
>
> On 13-09-2011 13:39, peter fuerst wrote:
>
>>> Date: Mon, 12 Sep 2011 13:56:36 +0400
>>> From: Sergei Shtylyov <sshtylyov@mvista.com>
>>> To: post@pfrst.de
>>> Cc: linux-mips@linux-mips.org, ralf@linux-mips.org,
>>> attilio.fiandrotti@gmail.com
>>> Subject: Re: [PATCH] Impact video driver for SGI Indigo2
>> ...
>
>   Indeed, they're not displayed (though due to "format=flowed" the patch is 
> not diasplyed correctly for me anyway).

You hit it! "quell-flowed-text" must be set explicitely to suppress
this spaces on an outgoing message.

>
>> indeed, where's a leading space in the diff, there's an additional space
>> inserted into the eMail-body. Have to find out the best way to suppress
>> this behaviour...
>
> ...
>
> WBR, Sergei
>
>

kind regards

peter
