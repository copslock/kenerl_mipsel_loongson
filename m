Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Apr 2009 13:54:11 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:28040 "EHLO lemote.com")
	by ftp.linux-mips.org with ESMTP id S20024859AbZDIMyF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 9 Apr 2009 13:54:05 +0100
Received: from localhost (localhost [127.0.0.1])
	by lemote.com (Postfix) with ESMTP id CF4043412F;
	Thu,  9 Apr 2009 20:50:59 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from lemote.com ([127.0.0.1])
	by localhost (www.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OMMq9udnVsBs; Thu,  9 Apr 2009 20:50:53 +0800 (CST)
Received: from [127.0.0.1] (unknown [222.92.8.142])
	by lemote.com (Postfix) with ESMTP id DCA53340D3;
	Thu,  9 Apr 2009 20:50:53 +0800 (CST)
Message-ID: <49DDEFD9.5050803@lemote.com>
Date:	Thu, 09 Apr 2009 20:53:45 +0800
From:	yanhua <yanh@lemote.com>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
CC:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	=?UTF-8?B?5b2t5Lqu6ZSm?= <penglj@lemote.com>,
	"zhangfx@lemote.com" <zhangfx@lemote.com>,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH 13/14] lemote: fixup for FUJITSU disk
References: <49DD83CA.9000704@lemote.com> <49DDE1D4.9080601@ru.mvista.com>
In-Reply-To: <49DDE1D4.9080601@ru.mvista.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <yanh@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22308
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yanh@lemote.com
Precedence: bulk
X-list: linux-mips

Sergei Shtylyov 写道:
> Hello.
>
> yanhua wrote:
>
>    The patch description wouldn't hurt, i.e. why this fixup is needed...
>
>   
>> diff --git a/drivers/ide/amd74xx.c b/drivers/ide/amd74xx.c
>> index 77267c8..51b888f 100644
>> --- a/drivers/ide/amd74xx.c
>> +++ b/drivers/ide/amd74xx.c
>>     
>
>    The IDE patches should be posted to linux-ide mail list.
>
>   
>> @@ -23,6 +23,11 @@
>>
>> #define DRV_NAME "amd74xx"
>>
>> +static const char *am74xx_quirk_drives[] = {
>> + "FUJITSU MHZ2160BH G2",
>> + NULL
>> +};
>> +
>> enum {
>> AMD_IDE_CONFIG = 0x41,
>> AMD_CABLE_DETECT = 0x42,
>> @@ -112,6 +117,20 @@ static void amd_set_pio_mode(ide_drive_t *drive,
>> const u8 pio)
>> amd_set_drive(drive, XFER_PIO_0 + pio);
>>     
>
>    Your patches are seriously whitespace-damaged, i.e. all tabs seem to be
> collapsed to a single space. You'll have to find a way to avoid that...
>
>   
>> }
>>
>> +static void amd_quirkproc(ide_drive_t *drive, const u8 pio)
>>     
>
>    Have you tried to compile this? The quirkproc() method only has one parameter.
Sorry for my mistake(after check, the compile reports a warning).
I have compiled it and test this on Yeeloong machines. 


>   
>> +{
>> + const char **list, *m = (char *)&drive->id[ATA_ID_PROD];
>> +
>> + for (list = am74xx_quirk_drives; *list != NULL; list++)
>> + if (strstr(m, *list) != NULL) {
>> + drive->quirk_list = 2;
>> + return;
>> + }
>> +
>> + drive->quirk_list = 0;
>> +
>> +}
>> +
>> static void amd7409_cable_detect(struct pci_dev *dev)
>> {
>> /* no host side cable detection */
>> @@ -194,6 +213,7 @@ static void __devinit init_hwif_amd74xx(ide_hwif_t
>> *hwif)
>> static const struct ide_port_ops amd_port_ops = {
>> .set_pio_mode = amd_set_pio_mode,
>> .set_dma_mode = amd_set_drive,
>> + .quirkproc = amd_quirkproc,
>> .cable_detect = amd_cable_detect,
>> };
>>
>>     
>
> MBR, Sergei
>
>   


-- 
晏华
