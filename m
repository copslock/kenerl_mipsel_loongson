Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Mar 2015 19:01:50 +0100 (CET)
Received: from mail-ie0-f181.google.com ([209.85.223.181]:35597 "EHLO
        mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009660AbbCWSBszNJh5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Mar 2015 19:01:48 +0100
Received: by ieclw3 with SMTP id lw3so42153919iec.2
        for <linux-mips@linux-mips.org>; Mon, 23 Mar 2015 11:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=MfpaMyAIJ1ZEHZv8nFqjA0QVNEQ7DM7ivkgM787/Wdc=;
        b=OOmT09k2NVavNX1KLXjdqJM/AhO6axqpuL1Vh1u8JykKT6QpP4FcbC6aGOMr6qutxu
         LQuA7N2RWF7z7iyPK4Osk/1UUz1aFTWaLT+obxQ3Ntj8+IS1y/uxs5zhJufXUIIihpYJ
         NXYek1Mb7WRrMNsQ96zbNKvVyQqsd1SHsTXKYCC8ufl8rD0b619FRuVR459pTwG1f8HS
         FnKVG4W70dB54PpOVTjG5fnaU7fuIOZxVC3bcMWubH9hCzbL769RYp9q/ycqVs/RSo0P
         Tk7TVET8GXZNbrP4wg4NKb8v8JL3ERDyYCXk/x/mD5yS3EKTaWrrdV9/7DQkGevGuegw
         OWSQ==
X-Received: by 10.107.7.18 with SMTP id 18mr490267ioh.69.1427133703560;
        Mon, 23 Mar 2015 11:01:43 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id b17sm1033087iob.31.2015.03.23.11.01.42
        for <linux-mips@linux-mips.org>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 23 Mar 2015 11:01:42 -0700 (PDT)
Message-ID: <55105505.6000909@gmail.com>
Date:   Mon, 23 Mar 2015 11:01:41 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH 2/3] MIPS: OCTEON: Add mach-cavium-octeon/mangle-port.h
References: <1426867920-7907-1-git-send-email-aleksey.makarov@auriga.com> <1426867920-7907-3-git-send-email-aleksey.makarov@auriga.com> <55101D58.1050309@auriga.com> <20150323141825.GB19416@paulmartin.codethink.co.uk>
In-Reply-To: <20150323141825.GB19416@paulmartin.codethink.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46500
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 03/23/2015 07:18 AM, Paul Martin wrote:
> On Mon, Mar 23, 2015 at 05:04:08PM +0300, Aleksey Makarov wrote:
>
>> With these patches the cn7000 board boots in little-endian mode with
>> all peripherials supported on this board working fine.  The peripherials
>> on other boards should probably be fixed separately.
>
> Including octeon-rng?  :-)

It should, I don't think there is any endian dependent code in there.

Most OCTEON drivers that don't do DMA should not have any hardware 
endian dependencies.

Things like I2C, MDIO, and SPI shouldn't need any changes.

David Daney
