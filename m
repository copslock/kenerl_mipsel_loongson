Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jun 2013 18:47:19 +0200 (CEST)
Received: from mail-pd0-f177.google.com ([209.85.192.177]:40982 "EHLO
        mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835001Ab3FSQrS228Ih (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Jun 2013 18:47:18 +0200
Received: by mail-pd0-f177.google.com with SMTP id p10so5192509pdj.8
        for <multiple recipients>; Wed, 19 Jun 2013 09:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=uJmellDy5B27WaPUjs6tQsNxG1GdVAPGUnPeT7gtf0s=;
        b=cwBY5R5EmnBhe1a1pYvhFUvpPNWDD0L/gpzWf1EfA1602amnjQihxjAAHFFr/Ck+rh
         HMfgr7lqBfMTt1LPsPhIeI08ASQ/F1dmoOF0OuV5o/Lju8TArXKxRbkxoeqKvC7UqtpI
         SKAuPdoA55mxo5ciKUzJ60vWtpcPUNtUD/xiBlIoGA59m1U6qVc7lb8vm5+dTAJ27InO
         VfVUpHyXmFZwRQqUGb44fmxqoKVuWVz7KB6rtJ7kf5S1xzk6bq7bRT/eMxUg0kj7r8Es
         yXP5vOEKWyBk9KN+c9MA1U3kzrOmUf4fDDbZM9A8ZivufNjv4OXRoOpVVo7IsoHfXsh3
         KoYg==
X-Received: by 10.68.28.232 with SMTP id e8mr3608124pbh.94.1371660432053;
        Wed, 19 Jun 2013 09:47:12 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id bg3sm23767429pbb.44.2013.06.19.09.47.09
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 19 Jun 2013 09:47:10 -0700 (PDT)
Message-ID: <51C1E08C.9040900@gmail.com>
Date:   Wed, 19 Jun 2013 09:47:08 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130514 Thunderbird/17.0.6
MIME-Version: 1.0
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Jamie Iles <jamie@jamieiles.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 3/5] tty/8250_dw: Add support for OCTEON UARTS.
References: <1371582775-12141-1-git-send-email-ddaney.cavm@gmail.com> <1371582775-12141-4-git-send-email-ddaney.cavm@gmail.com> <20130619141008.GA32331@xps8300>
In-Reply-To: <20130619141008.GA32331@xps8300>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37012
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

On 06/19/2013 07:10 AM, Heikki Krogerus wrote:
> On Tue, Jun 18, 2013 at 12:12:53PM -0700, David Daney wrote:
>> A few differences needed by OCTEON:
>>
>> o These are DWC UARTS, but have USR at a different offset.
>>
>> o OCTEON must have 64-bit wide register accesses, so we have OCTEON
>>    specific register accessors.
>>
>> o No UCV register, so we hard code some properties.
>>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>
> <snip>
>
>> @@ -270,10 +301,8 @@ static int dw8250_probe(struct platform_device *pdev)
>>   	uart.port.serial_out = dw8250_serial_out;
>>   	uart.port.private_data = data;
>>
>> -	dw8250_setup_port(&uart);
>> -
>>   	if (pdev->dev.of_node) {
>> -		err = dw8250_probe_of(&uart.port);
>> +		err = dw8250_probe_of(&uart.port, data);
>>   		if (err)
>>   			return err;
>>   	} else if (ACPI_HANDLE(&pdev->dev)) {
>> @@ -284,6 +313,9 @@ static int dw8250_probe(struct platform_device *pdev)
>>   		return -ENODEV;
>>   	}
>>
>> +	if (!data->no_ucv)
>> +		dw8250_setup_port(&uart);
>
> Moving the dw8250_setup_port() call here breaks dw8250_probe_acpi(). It
> expects values from the CPR register for the DMA burst size calculation.
>
> The DMA support can be moved to a separate function. This way it can
> be called after this point, and it will then be available for both DT
> and ACPI. I can make a patch tomorrow. That should solve this issue.
>

I am reworking the patch because other problems were found.  I will try 
to get this part right in the next version.

David Daney
