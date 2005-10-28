Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Oct 2005 23:20:19 +0100 (BST)
Received: from baldrick.bootc.net ([83.142.228.48]:14286 "EHLO
	baldrick.bootc.net") by ftp.linux-mips.org with ESMTP
	id S8133641AbVJ1WUA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 28 Oct 2005 23:20:00 +0100
Received: from [192.168.1.6] (cpc4-hudd6-3-1-cust172.hudd.cable.ntl.com [82.21.103.172])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by baldrick.bootc.net (Postfix) with ESMTP id C907D1400C02
	for <linux-mips@linux-mips.org>; Fri, 28 Oct 2005 23:20:14 +0100 (BST)
Mime-Version: 1.0 (Apple Message framework v734)
In-Reply-To: <20051027102912.GB17645@linux-mips.org>
References: <18E0376E-A524-42EE-A5ED-BDF9A0668DE6@bootc.net> <20051027102912.GB17645@linux-mips.org>
Content-Type: multipart/signed; micalg=sha1; boundary=Apple-Mail-1--240525819; protocol="application/pkcs7-signature"
Message-Id: <942B8B78-5F73-4647-AAA6-6025EABEDD1E@bootc.net>
From:	Chris Boot <bootc@bootc.net>
Subject: Re: Execute-in-Place (XIP)
Date:	Fri, 28 Oct 2005 23:20:12 +0100
To:	linux-mips@linux-mips.org
X-Mailer: Apple Mail (2.734)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at bootc.plus.com
Return-Path: <bootc@bootc.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9378
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bootc@bootc.net
Precedence: bulk
X-list: linux-mips


--Apple-Mail-1--240525819
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

On 27 Oct 2005, at 11:29, Ralf Baechle wrote:

> On Thu, Oct 27, 2005 at 10:02:40AM +0100, Chris Boot wrote:
>
>
>> Due to the puny amounts of RAM (2MB) on my board, I'm going to have
>> to use XIP so that RAM isn't being taken up by kernel code. I was
>> looking around for MIPS XIP patches and all I could find was in the
>> linux-vr tree which seems, well, dead.
>>
>
> The linux-vr tree is kept online for people to dig out the goodies  
> which
> may be left in there :-)
>
>
>> Does anyone know of any more
>> recent patches or should I undertake the work of porting the patch to
>> a more recent 2.4 kernel?
>>
>
> I guess you'll have to do that.  The alternative would be to port the
> 2.6 ARM XIP_KERNEL implementation.
>
>   Ralf

Looks like I'm getting somewhere! I still don't have a JTAG or any  
way to test the kernels I've built, but readelf provides good looking  
results and my flat binary image looks like it will do the right thing.

Basically what I've done is ported over the XIP code from the linux- 
vr tree but renamed config symbols to be more similar to the ARM XIP  
code in 2.6, so then I can port the 2.6 MTD code into my 2.4 tree (if  
possible) that little bit more easily.

The only remaining question now is: the kernel_entry symbol seems to  
be placed pretty randomly in my kernel image, and the way I'm finding  
it now is by getting the entry point address from readelf. Is there a  
way I can either move this to be at the start of the image or insert  
the entry point address at the start of my image? Surely I can't be  
expected to hand-edit an entry point address in my bootloader and  
flash the lot to run my kernel, can I?

Many thanks,
Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/



--Apple-Mail-1--240525819
Content-Transfer-Encoding: base64
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Disposition: attachment;
	filename=smime.p7s

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGEjCCAssw
ggI0oAMCAQICAw4IwzANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhh
d3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVt
YWlsIElzc3VpbmcgQ0EwHhcNMDUwMjE0MjEyNjMzWhcNMDYwMjE0MjEyNjMzWjBBMR8wHQYDVQQD
ExZUaGF3dGUgRnJlZW1haWwgTWVtYmVyMR4wHAYJKoZIhvcNAQkBFg9ib290Y0Bib290Yy5uZXQw
ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC6aATCjyi9z5A42up8tmL1D0gc/TvBsCIJ
ehXpdQJ1gGC5d6MlKLpQIF8zVzOjwOkFO7hluPVVAzrSo5/jvcSCl2SYj0OMiBS3BZh7JBMb6Ld+
+I5zrKnQFA4OCtBfaDS4xpErhjCgxYo4uk0HCJyI9T/foELKVJba4iRdnmggI513ifG8eIV94y+Z
rSVgejMisnLOM9xg0LfWwJZmbnYcszvkGKmAWzzqGfZFig2AR8I/NnVqYwr42JDlFMNKsz0kNdeq
ED29yI8IGITfzk3Xc5eMfm2PPEs1drf6vfR38GBLYL8UkgAbtTBiRvte4jS+aA6kKyvN0gIDq2+S
r06HAgMBAAGjLDAqMBoGA1UdEQQTMBGBD2Jvb3RjQGJvb3RjLm5ldDAMBgNVHRMBAf8EAjAAMA0G
CSqGSIb3DQEBBAUAA4GBAID0mAm4oxd1eY6KoCmdoTGfkeaYBnP+vd00juiKXwlYfZ1/TPMCbIeD
KHINuQbIUVH3u+vga56aaiwj31EG6D/7O8GePQPDo4HSgbo6cfGM21ELowr2e/qUg1EyoWwhATak
QDYLSBEIdAsQJnUwV32LZA/PFYGu0S5i25u7d4FpMIIDPzCCAqigAwIBAgIBDTANBgkqhkiG9w0B
AQUFADCB0TELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2Fw
ZSBUb3duMRowGAYDVQQKExFUaGF3dGUgQ29uc3VsdGluZzEoMCYGA1UECxMfQ2VydGlmaWNhdGlv
biBTZXJ2aWNlcyBEaXZpc2lvbjEkMCIGA1UEAxMbVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIENB
MSswKQYJKoZIhvcNAQkBFhxwZXJzb25hbC1mcmVlbWFpbEB0aGF3dGUuY29tMB4XDTAzMDcxNzAw
MDAwMFoXDTEzMDcxNjIzNTk1OVowYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25z
dWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1
aW5nIENBMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDEpjxVc1X7TrnKmVoeaMB1BHCd3+n/
ox7svc31W/Iadr1/DDph8r9RzgHU5VAKMNcCY1osiRVwjt3J8CuFWqo/cVbLrzwLB+fxH5E2JCoT
zyvV84J3PQO+K/67GD4Hv0CAAmTXp6a7n2XRxSpUhQ9IBH+nttE8YQRAHmQZcmC3+wIDAQABo4GU
MIGRMBIGA1UdEwEB/wQIMAYBAf8CAQAwQwYDVR0fBDwwOjA4oDagNIYyaHR0cDovL2NybC50aGF3
dGUuY29tL1RoYXd0ZVBlcnNvbmFsRnJlZW1haWxDQS5jcmwwCwYDVR0PBAQDAgEGMCkGA1UdEQQi
MCCkHjAcMRowGAYDVQQDExFQcml2YXRlTGFiZWwyLTEzODANBgkqhkiG9w0BAQUFAAOBgQBIjNFQ
g+oLLswNo2asZw9/r6y+whehQ5aUnX9MIbj4Nh+qLZ82L8D0HFAgk3A8/a3hYWLD2ToZfoSxmRsA
xRoLgnSeJVCUYsfbJ3FXJY3dqZw5jowgT2Vfldr394fWxghOrvbqNOUQGls1TXfjViF4gtwhGTXe
JLHTHUb/XV9lTzGCAucwggLjAgEBMGkwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBD
b25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJ
c3N1aW5nIENBAgMOCMMwCQYFKw4DAhoFAKCCAVMwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAc
BgkqhkiG9w0BCQUxDxcNMDUxMDI4MjIyMDEzWjAjBgkqhkiG9w0BCQQxFgQUIbnmfXz8wwQ6my2O
1kMovSjbBgIweAYJKwYBBAGCNxAEMWswaTBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3Rl
IENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWls
IElzc3VpbmcgQ0ECAw4IwzB6BgsqhkiG9w0BCRACCzFroGkwYjELMAkGA1UEBhMCWkExJTAjBgNV
BAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25h
bCBGcmVlbWFpbCBJc3N1aW5nIENBAgMOCMMwDQYJKoZIhvcNAQEBBQAEggEAEeYBrCXbMWnO6Pze
HBeoVufnIriGY95KiXGrkDspvZ+oMsQCEXWoJdqH82nnum7Cc8c1+7SDLxbQuJHNsdEXBwdZv2lo
EVBTSbjTfTGEjVJ/kO9m19wY5TxWZ0WI9dfNQ9SAfkVJyJ9tQY4KS9l3tr3Gb9DOZp+MeUuYnM57
Xqnaks5g5DEyK15iHwtgizZBRNuCMkbTWtSHJSdjwfNi1vDN8Af57Rl5A/a9794IspMVRtVzvCV+
HnnJUjaoW3DAXw8YDK/FAx8TuIpHI2TM0xRid0ez71trsn1IUEgYSeCWePEh6nCn/uoZR0YECBBW
CLs5rNTOyxiXzm+GX9aMGgAAAAAAAA==

--Apple-Mail-1--240525819--
