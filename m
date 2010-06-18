Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jun 2010 12:24:20 +0200 (CEST)
Received: from t111.niisi.ras.ru ([193.232.173.111]:46369 "EHLO
        t111.niisi.ras.ru" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491062Ab0FRKYN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Jun 2010 12:24:13 +0200
Received: from aa19.niisi.msk.ru (aa19.niisi.msk.ru [172.16.0.19] (may be forged))
        by t111.niisi.ras.ru (8.13.8/8.13.8) with ESMTP id o5IAOCA7006067;
        Fri, 18 Jun 2010 14:24:12 +0400
Received: from [192.168.173.2] (aa248 [172.16.0.248])
        by aa19.niisi.msk.ru (8.13.8/8.13.8) with ESMTP id o5IA8uZw013295;
        Fri, 18 Jun 2010 14:08:56 +0400
Message-ID: <4C1B4C0A.9070506@niisi.msk.ru>
Date:   Fri, 18 Jun 2010 14:35:54 +0400
From:   "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     David Daney <ddaney@caviumnetworks.com>,
        Jesper Nilsson <jesper@jni.nu>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: MIPS: return after handling coprocessor 2 exception
References: <20100617132554.GB24162@jni.nu> <4C1A57AE.9080706@caviumnetworks.com> <4C1B263E.7070906@niisi.msk.ru> <20100618100053.GA4466@linux-mips.org>
In-Reply-To: <20100618100053.GA4466@linux-mips.org>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus: Dr.Web (R) for Mail Servers on t111.niisi.ras.ru host
X-Antivirus-Code: 100000
X-archive-position: 27169
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raiko@niisi.msk.ru
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 12772

On 18.06.2010 14:00, Ralf Baechle wrote:
> static int default_cu2_call(struct notifier_block *nfb, unsigned long action,
>          void *data)
> {
> 	...
>
> 	return NOTIFY_OK | NOTIFY_STOP;
NOTIFY_STOP implies NOTIFY_OK, so
	return NOTIFY_STOP;
shall be enough.
> }

> The notifier list could also be used for example by perf

Or octeon cop2 handler that just sends NOTIFY_BAD for getting the same 
behavior.

Gleb.
