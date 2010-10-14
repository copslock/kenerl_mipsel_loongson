Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Oct 2010 10:43:09 +0200 (CEST)
Received: from mail-qy0-f177.google.com ([209.85.216.177]:33232 "EHLO
        mail-qy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491029Ab0JNInD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Oct 2010 10:43:03 +0200
Received: by qyk4 with SMTP id 4so4804698qyk.15
        for <multiple recipients>; Thu, 14 Oct 2010 01:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=I8QmIIyV0AoLfTbrELJmLUWbahLijMKhwpK7DbQUb+w=;
        b=Eeup6HKO5o6Pzw+XFTjp13A4EIxOZIsdFzn4/WvP/+AxWeoF15GuHoFR76SvVJKFGy
         bPkaO2ku3FivYN6NKmkJe/NxES+/4lCYMelQ1PU+p9/u8qenSj6cdV3DsZMhmU4YWpF2
         upjdMQyXCNSabOSMEjV37R9AT+t1il3lEuvLc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=mgE/UHhPCsYPirZ4X6OIIopFFvfZ2SLWxjbUfDrn22xjkuBj3ayyzqzsZUATCxMYob
         vKchcqbuR9bERgAMwf6lzgwNtrDYmZq6b7/cU97xj1E/HtfalMdAoPguA8Zvmm9oVPn9
         c5DyUhncUni1AhMctUjMU7b/LwTxYw/wxsVgc=
Received: by 10.229.227.209 with SMTP id jb17mr7340239qcb.281.1287045777125;
        Thu, 14 Oct 2010 01:42:57 -0700 (PDT)
Received: from bd.yyz.us (99-173-148-118.lightspeed.rlghnc.sbcglobal.net [99.173.148.118])
        by mx.google.com with ESMTPS id l13sm9268066qck.19.2010.10.14.01.42.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 14 Oct 2010 01:42:55 -0700 (PDT)
Message-ID: <4CB6C28D.5070805@pobox.com>
Date:   Thu, 14 Oct 2010 04:42:53 -0400
From:   Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100921 Fedora/3.1.4-1.fc13 Thunderbird/3.1.4
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH 12/14] ata: pata_octeon_cf: Use I/O clock rate for timing
 calculations.
References: <1286492633-26885-1-git-send-email-ddaney@caviumnetworks.com> <1286492633-26885-13-git-send-email-ddaney@caviumnetworks.com> <20101011134354.GI30695@linux-mips.org>
In-Reply-To: <20101011134354.GI30695@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jgpobox@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28063
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jgarzik@pobox.com
Precedence: bulk
X-list: linux-mips

On 10/11/2010 09:43 AM, Ralf Baechle wrote:
> On Thu, Oct 07, 2010 at 04:03:51PM -0700, David Daney wrote:
>
>> The creation of the I/O clock domain requires some adjustments.  Since
>> the CF bus timing logic is clocked by the I/O clock, use its rate for
>> delay calculations.
>>
>> Signed-off-by: David Daney<ddaney@caviumnetworks.com>
>> Cc: Jeff Garzik<jgarzik@pobox.com>
>> Cc: linux-ide@vger.kernel.org
>
> Haven't seen any ack yet but I assume due to the dependencies on other
> MIPS patches it'll be ok if I merge this through the MIPS tree, so I
> queued it for 2.6.37.

yep,

Acked-by: Jeff Garzik <jgarzik@redhat.com>
