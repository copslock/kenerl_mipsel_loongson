Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Sep 2006 22:41:44 +0100 (BST)
Received: from web31504.mail.mud.yahoo.com ([68.142.198.133]:18613 "HELO
	web31504.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20038516AbWIFVln (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 6 Sep 2006 22:41:43 +0100
Received: (qmail 54754 invoked by uid 60001); 6 Sep 2006 21:41:36 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=4hWps08PpcZiUxBC8xmMCJ7tkf1LW39Ly1pAwSddZbB5apRZj9tzTjWjchF5iBnVoC6y4X3qf59ijHuaId4ayXGZy5gVUFOYUepB6jtv1iJcO89CgJcMfdqpMj5umoaTEJUm5NFuWhwXt3Wk4vv0MFLuWgr1O0UAHCSIq69b9v8=  ;
Message-ID: <20060906214136.54752.qmail@web31504.mail.mud.yahoo.com>
Received: from [70.103.67.194] by web31504.mail.mud.yahoo.com via HTTP; Wed, 06 Sep 2006 14:41:36 PDT
Date:	Wed, 6 Sep 2006 14:41:36 -0700 (PDT)
From:	Jonathan Day <imipak@yahoo.com>
Subject: Resetting a Broadcom in software
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1897457798-1157578896=:54718"
Content-Transfer-Encoding: 8bit
Return-Path: <imipak@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12525
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: imipak@yahoo.com
Precedence: bulk
X-list: linux-mips

--0-1897457798-1157578896=:54718
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Hi,

A co-worker wrote the following test of the Broadcom's
maths abilities and discovered that it reboots some
(but not all) MIPS processors it has been tested on.
It'll reboot the Sentosa, for example, but NOT the
Swarm.

(Apologies for the ugly coding, btw.)

You just make the first file, the ATL_ file gets
included into it. The compiler flags I'm using are:

-march=sb1 -mabi=64 -fomit-frame-pointer -O3 -mips64
-mfused-madd

The program doesn't link to anything and no linker
flags are needed.

This begs three questions:

1) What is happening to cause the CPU to reset? (It's
not a kernel bug, it's an actual CPU reset)

2) What is NOT happening on the Swarm, allowing it to
work fine?

3) Is the problem in the category of "preventable in
hardware", "preventable in the kernel", or
"preventable by slowly roasting those coders who write
like this"?


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-1897457798-1157578896=:54718
Content-Type: application/octet-stream; name="reboot.c"
Content-Transfer-Encoding: base64
Content-Description: 2267489636-reboot.c
Content-Disposition: attachment; filename="reboot.c"

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1
ZGUgPHN5cy90eXBlcy5oPgojaW5jbHVkZSA8c3RyaW5nLmg+ICAgICAvKiBG
b3Igc3RyZXJyb3IoKSAqLwojaW5jbHVkZSA8ZXJybm8uaD4gICAgICAvKiBG
b3IgZXJybm8gKi8KI2luY2x1ZGUgPHVuaXN0ZC5oPiAgICAgLyogRm9yIGZv
cmsoKSAqLwojaW5jbHVkZSA8cHRocmVhZC5oPiAgICAvKiBGb3IgY3B1X3Nl
dF90ICovCiNpbmNsdWRlIDxzeXMvd2FpdC5oPiAgIC8qIEZvciB3YWl0cGlk
KCkgKi8KCgojZGVmaW5lIElURVJBVElPTlMgMTAwMAojZGVmaW5lIEFSUkFZ
X1NJWkUgNjAKCiNkZWZpbmUgVFlQRSBkb3VibGUKI2RlZmluZSBBVExfVVNF
Uk1NIEFUTF9kSklLNjB4NjB4NDhUTjQ4eDQ4eDBfYTFfYjEKI2RlZmluZSBC
RVRBMQojZGVmaW5lIE1CIEFSUkFZX1NJWkUKI2RlZmluZSBOQiBBUlJBWV9T
SVpFCiNkZWZpbmUgS0IgQVJSQVlfU0laRQojaW5jbHVkZSAiQVRMX2RtbTEy
eDF4MTJfbWlwcy5jIgoKCgoKZXh0ZXJuIGludCBzY2hlZF9zZXRhZmZpbml0
eSAoX19waWRfdCBfX3BpZCwgc2l6ZV90IF9fY3B1c2V0c2l6ZSwKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgX19jb25zdCBjcHVfc2V0X3QgKl9f
Y3B1c2V0KSBfX1RIUk9XOwoKc3RhdGljIF9faW5saW5lX18gVFlQRSBsZl9y
YW5kb20odm9pZCkKewogICAgcmV0dXJuICgoVFlQRSkocmFuZG9tKCkgLSAo
UkFORF9NQVggLyAyKSkpIC8gMTAwMC4wOwp9CgppbnQgbWFpbihpbnQgYXJn
YywgY2hhciAqKmFyZ3YpCnsKICAgIHBpZF90IHBpZDsKICAgIGNwdV9zZXRf
dCBjcHVzZXQgPSB7ezB9fTsKICAgIHJlZ2lzdGVyIGludCBpOwogICAgVFlQ
RSAqcE1lbW9yeTsKICAgIHJlZ2lzdGVyIFRZUEUgKkE7CiAgICByZWdpc3Rl
ciBUWVBFICpCOwogICAgcmVnaXN0ZXIgVFlQRSAqQzsKCiAgICBwaWQgPSBm
b3JrKCk7CiAgICBpZiAocGlkID09IDApCiAgICB7CiAgICAgICAgLyogY2hp
bGQgKi8KICAgICAgICBjcHVzZXQuX19iaXRzWzBdID0gMTsKICAgIH0KICAg
IGVsc2UKICAgIHsKICAgICAgICAvKiBwYXJlbnQgKi8KICAgICAgICBjcHVz
ZXQuX19iaXRzWzBdID0gMjsKICAgIH0KCiAgICBpZiAoc2NoZWRfc2V0YWZm
aW5pdHkoMCwgc2l6ZW9mKGNwdXNldCksICZjcHVzZXQpICE9IDApCiAgICB7
CiAgICAgICBmcHJpbnRmKHN0ZG91dCwgIiVzKCVkKTogc2NoZWRfc2V0YWZm
aW5pdHkgcmV0dXJuZWQgJWQ6ICVzXG4iLCBfX2Z1bmNfXywgcGlkLCBlcnJu
bywgc3RyZXJyb3IoZXJybm8pKTsKICAgIH0KCiAgICAvKiBBIGxpdHRsZSBi
aXQgb2YgRlAgRkNTUiBtYWdpYy4uLiAqLwogICAgaSA9IDA7CiAgICBfX2Fz
bV9fIHZvbGF0aWxlICgiY2ZjMVx0JTAsICQyOFxuXHRvcmlcdCUwLCAlMCwg
MHg0XG5cdGN0YzFcdCUwLCAkMjgiIDogOiAiciIgKGkpKTsKCiAgICBwTWVt
b3J5ID0gKFRZUEUgKiltYWxsb2MoKEFSUkFZX1NJWkUgKiBBUlJBWV9TSVpF
ICogMykgKiBzaXplb2YoVFlQRSkpOwogICAgaWYgKHBNZW1vcnkgPT0gTlVM
TCkKICAgIHsKICAgICAgIGZwcmludGYoc3Rkb3V0LCAiJXMoJWQpOiBtYWxs
b2MgZmFpbGVkXG4iLCBfX2Z1bmNfXywgcGlkKTsKICAgICAgIHJldHVybiAy
OwogICAgfQoKICAgIEMgPSBwTWVtb3J5OwogICAgQiA9IEMgKyAoQVJSQVlf
U0laRSAqIEFSUkFZX1NJWkUpOwogICAgQSA9IEIgKyAoQVJSQVlfU0laRSAq
IEFSUkFZX1NJWkUpOwogICAgZm9yIChpID0gMDsgaSA8IChBUlJBWV9TSVpF
ICogQVJSQVlfU0laRSk7ICsraSkKICAgIHsKICAgICAgICBBW2ldID0gbGZf
cmFuZG9tKCk7CiAgICAgICAgQltpXSA9IGxmX3JhbmRvbSgpOwogICAgfQoK
ICAgIGZwcmludGYoc3Rkb3V0LCAiJWQ6IHN0YXJ0XG4iLCBnZXRwaWQoKSk7
CiAgICBmb3IgKGkgPSBJVEVSQVRJT05TOyBpOyAtLWkpCiAgICB7CiNpZiAw
CiAgICAgICAgZnByaW50ZihzdGRvdXQsICIlZDogaXRlcmF0aW9uICVkXG4i
LCBnZXRwaWQoKSwgaSk7CiNlbmRpZgogICAgICAgIEFUTF9VU0VSTU0oQVJS
QVlfU0laRSwgQVJSQVlfU0laRSwgQVJSQVlfU0laRSwgMS4wLCBBLCBBUlJB
WV9TSVpFLCBCLCBBUlJBWV9TSVpFLCAxLjAsIEMsIEFSUkFZX1NJWkUpOwog
ICAgfQoKICAgIGZwcmludGYoc3Rkb3V0LCAiJWQ6IGRvbmVcbiIsIGdldHBp
ZCgpKTsKICAgIGZyZWUocE1lbW9yeSk7CiAgICByZXR1cm4gMDsKfQoK

--0-1897457798-1157578896=:54718
Content-Type: application/octet-stream; name="ATL_dmm12x1x12_mips.c"
Content-Transfer-Encoding: base64
Content-Description: 173074032-ATL_dmm12x1x12_mips.c
Content-Disposition: attachment; filename="ATL_dmm12x1x12_mips.c"

LyoKI2luY2x1ZGUgImF0bGFzX21pc2MuaCIKICovCgojZGVmaW5lIExGX0RH
RU1NX0JMT0NLICAgICAgMTIKI2RlZmluZSBMRl9ER0VNTV9QUkVGRVRDSCAg
IDEKCiNkZWZpbmUgICAgICAgTUlQUwojaWYgICBkZWZpbmVkKE1JUFMpCiAg
I2RlZmluZSBMRl9MREMxKGZkLCBwLCBfX3ZhcnMpIFwKICAgIF9fYXNtX18g
dm9sYXRpbGUgKCJsZGMxXHQlMCwlMiglMSkiIDogIj1mIihmZCkgOiAiciIo
cCksICJuIigoX192YXJzKSpzaXplb2YoVFlQRSkpKQogICNkZWZpbmUgTEZf
U0RDMShmcywgcCwgX192YXJzKSBcCiAgICBfX2FzbV9fIHZvbGF0aWxlICgi
c2RjMVx0JTAsJTIoJTEpIiA6IDogImYiKGZzKSwgInIiKHApLCAibiIoKF9f
dmFycykqc2l6ZW9mKFRZUEUpKSkKICAjZGVmaW5lIExGX01VTChmZCwgZnMp
IFwKICAgIF9fYXNtX18gdm9sYXRpbGUgKCJtdWwuZFx0JTAsJTAsJTEiIDog
IitmIihmZCkgOiAiZiIoZnMpKQogICNkZWZpbmUgTEZfTUFERChmZCwgZnMx
LCBmczIpIFwKICAgIF9fYXNtX18gdm9sYXRpbGUgKCJtYWRkLmRcdCUwLCUw
LCUxLCUyIiA6ICIrZiIoZmQpIDogImYiKGZzMSksICJmIihmczIpKQogICNp
ZiAoTEZfREdFTU1fUFJFRkVUQ0ggIT0gMCkKICAgICNkZWZpbmUgTEZfREdF
TU1fUFJFRl9MT0FEKGFkZHJlc3MsdmFycykgXAogICAgICBfX2FzbV9fIHZv
bGF0aWxlICgicHJlZiAwLCAlMSglMCkiIDogOiAiciIoYWRkcmVzcyksICJu
IigodmFycykqc2l6ZW9mKFRZUEUpKSkKICAjZWxzZSAgLyogTEZfREdFTU1f
UFJFRkVUQ0ggPT0gMCAqLwogICAgI2RlZmluZSBMRl9ER0VNTV9QUkVGX0xP
QUQoYWRkcmVzcyx2YXJzKQogICNlbmRpZgogICNpZiAwCiAgICAjZGVmaW5l
IExGX0FTTSh4KQogICNlbHNlCiAgICAvKiBVc2VkIG9ubHkgZm9yIGFubm90
YXRpbmcgYXNzZW1ibHkgbGlzdGluZ3MgKi8KICAgICNkZWZpbmUgTEZfQVNN
KHgpIF9fYXNtX18oeCkKICAjZW5kaWYKI2Vsc2UKICAjZGVmaW5lIExGX0xE
QzEoZmQsIHAsIF9fdmFycykgZmQgPSAocClbX192YXJzXQogICNkZWZpbmUg
TEZfU0RDMShmcywgcCwgX192YXJzKSAocClbX192YXJzXSA9IGZzCiAgI2Rl
ZmluZSBMRl9NVUwoZmQsIGZzKSBmZCAqPSBmcwogICNkZWZpbmUgTEZfTUFE
RChmZCwgZjEsIGYyKSBmZCArPSBmMSAqIGYyCiAgI2lmIChMRl9ER0VNTV9Q
UkVGRVRDSCAhPSAwKQogICAgI2luY2x1ZGUgImF0bGFzX3ByZWZldGNoLmgi
CiAgICAjZGVmaW5lIExGX0RHRU1NX1BSRUZfTE9BRChhZGRyZXNzLHZhcnMp
IEFUTF9wZmwxUigmYWRkcmVzc1t2YXJzXSkKICAjZWxzZSAgLyogTEZfREdF
TU1fUFJFRkVUQ0ggPT0gMCAqLwogICAgI2RlZmluZSBMRl9ER0VNTV9QUkVG
X0xPQUQoYWRkcmVzcyx2YXJzKQogICNlbmRpZiAvKiBMRl9ER0VNTV9QUkVG
RVRDSCA9PSAwICovCiAgI2RlZmluZSBMRl9BU00oeCkKI2VuZGlmCgoKI2Rl
ZmluZSBQUkVGRVRDSF9ST1cocCx2YXJzKSBcCnsgXAogICAgTEZfQVNNKCIu
Z2xvYmwgUFJFRkVUQ0hfUk9XIik7IFwKICAgIExGX0RHRU1NX1BSRUZfTE9B
RChwLCAodmFycykrMCk7IFwKICAgIExGX0RHRU1NX1BSRUZfTE9BRChwLCAo
dmFycykrNCk7IFwKICAgIExGX0RHRU1NX1BSRUZfTE9BRChwLCAodmFycykr
OCk7IFwKfQoKI2RlZmluZSBQUkVGRVRDSF9DT0wocCx2YXJzKSBcCnsgXAog
ICAgTEZfQVNNKCIuZ2xvYmwgUFJFRkVUQ0hfQ09MIik7IFwKICAgIExGX0RH
RU1NX1BSRUZfTE9BRChwLCAwKktCKyh2YXJzKSk7IFwKICAgIExGX0RHRU1N
X1BSRUZfTE9BRChwLCAxKktCKyh2YXJzKSk7IFwKICAgIExGX0RHRU1NX1BS
RUZfTE9BRChwLCAyKktCKyh2YXJzKSk7IFwKICAgIExGX0RHRU1NX1BSRUZf
TE9BRChwLCAzKktCKyh2YXJzKSk7IFwKICAgIExGX0RHRU1NX1BSRUZfTE9B
RChwLCA0KktCKyh2YXJzKSk7IFwKICAgIExGX0RHRU1NX1BSRUZfTE9BRChw
LCA1KktCKyh2YXJzKSk7IFwKICAgIExGX0RHRU1NX1BSRUZfTE9BRChwLCA2
KktCKyh2YXJzKSk7IFwKICAgIExGX0RHRU1NX1BSRUZfTE9BRChwLCA3KktC
Kyh2YXJzKSk7IFwKICAgIExGX0RHRU1NX1BSRUZfTE9BRChwLCA4KktCKyh2
YXJzKSk7IFwKICAgIExGX0RHRU1NX1BSRUZfTE9BRChwLCA5KktCKyh2YXJz
KSk7IFwKICAgIExGX0RHRU1NX1BSRUZfTE9BRChwLCAxMCpLQisodmFycykp
OyBcCiAgICBMRl9ER0VNTV9QUkVGX0xPQUQocCwgMTEqS0IrKHZhcnMpKTsg
XAp9CgojZGVmaW5lIFNUT1JFX0NfQkVUQTAodmFycykgXAp7IFwKICAgIExG
X0FTTSgiLmdsb2JsIFNUT1JFX0NfQkVUQTAiKTsgXAogICAgTEZfTVVMKGMw
MCwgYWxwaGEpOyBcCiAgICBMRl9NVUwoYzAxLCBhbHBoYSk7IFwKICAgIExG
X01VTChjMDIsIGFscGhhKTsgXAogICAgTEZfTVVMKGMwMywgYWxwaGEpOyBc
CiAgICBMRl9NVUwoYzA0LCBhbHBoYSk7IFwKICAgIExGX01VTChjMDUsIGFs
cGhhKTsgXAogICAgTEZfTVVMKGMwNiwgYWxwaGEpOyBcCiAgICBMRl9NVUwo
YzA3LCBhbHBoYSk7IFwKICAgIExGX01VTChjMDgsIGFscGhhKTsgXAogICAg
TEZfTVVMKGMwOSwgYWxwaGEpOyBcCiAgICBMRl9NVUwoYzEwLCBhbHBoYSk7
IFwKICAgIExGX01VTChjMTEsIGFscGhhKTsgXAogICAgUFJFRkVUQ0hfUk9X
KHBDLCBMRl9ER0VNTV9QUkVGRVRDSCAqIExGX0RHRU1NX0JMT0NLKTsgXAog
ICAgTEZfU0RDMShjMDAsIHBDLCAodmFycykrMCk7IFwKICAgIExGX1NEQzEo
YzAxLCBwQywgKHZhcnMpKzEpOyBcCiAgICBMRl9TREMxKGMwMiwgcEMsICh2
YXJzKSsyKTsgXAogICAgTEZfU0RDMShjMDMsIHBDLCAodmFycykrMyk7IFwK
ICAgIExGX1NEQzEoYzA0LCBwQywgKHZhcnMpKzQpOyBcCiAgICBMRl9TREMx
KGMwNSwgcEMsICh2YXJzKSs1KTsgXAogICAgTEZfU0RDMShjMDYsIHBDLCAo
dmFycykrNik7IFwKICAgIExGX1NEQzEoYzA3LCBwQywgKHZhcnMpKzcpOyBc
CiAgICBMRl9TREMxKGMwOCwgcEMsICh2YXJzKSs4KTsgXAogICAgTEZfU0RD
MShjMDksIHBDLCAodmFycykrOSk7IFwKICAgIExGX1NEQzEoYzEwLCBwQywg
KHZhcnMpKzEwKTsgXAogICAgTEZfU0RDMShjMTEsIHBDLCAodmFycykrMTEp
OyBcCn0KCiNkZWZpbmUgU1RPUkVfQ19CRVRBMSh2YXJzKSBcCnsgXAogICAg
TEZfQVNNKCIuZ2xvYmwgU1RPUkVfQ19CRVRBMSIpOyBcCiAgICBMRl9MREMx
KGEwLCBwQywgKHZhcnMpKzApOyBcCiAgICBMRl9MREMxKGExLCBwQywgKHZh
cnMpKzEpOyBcCiAgICBMRl9NQUREKGEwLCBjMDAsIGFscGhhKTsgXAogICAg
TEZfTUFERChhMSwgYzAxLCBhbHBoYSk7IFwKICAgIExGX0xEQzEoYzAwLCBw
QywgKHZhcnMpKzIpOyBcCiAgICBMRl9MREMxKGMwMSwgcEMsICh2YXJzKSsz
KTsgXAogICAgTEZfTUFERChjMDAsIGMwMiwgYWxwaGEpOyBcCiAgICBMRl9N
QUREKGMwMSwgYzAzLCBhbHBoYSk7IFwKICAgIExGX0xEQzEoYzAyLCBwQywg
KHZhcnMpKzQpOyBcCiAgICBMRl9MREMxKGMwMywgcEMsICh2YXJzKSs1KTsg
XAogICAgTEZfTUFERChjMDIsIGMwNCwgYWxwaGEpOyBcCiAgICBMRl9NQURE
KGMwMywgYzA1LCBhbHBoYSk7IFwKICAgIExGX0xEQzEoYzA0LCBwQywgKHZh
cnMpKzYpOyBcCiAgICBMRl9MREMxKGMwNSwgcEMsICh2YXJzKSs3KTsgXAog
ICAgTEZfTUFERChjMDQsIGMwNiwgYWxwaGEpOyBcCiAgICBMRl9NQUREKGMw
NSwgYzA3LCBhbHBoYSk7IFwKICAgIExGX0xEQzEoYzA2LCBwQywgKHZhcnMp
KzgpOyBcCiAgICBMRl9MREMxKGMwNywgcEMsICh2YXJzKSs5KTsgXAogICAg
TEZfTUFERChjMDYsIGMwOCwgYWxwaGEpOyBcCiAgICBMRl9NQUREKGMwNywg
YzA5LCBhbHBoYSk7IFwKICAgIExGX0xEQzEoYzA4LCBwQywgKHZhcnMpKzEw
KTsgXAogICAgTEZfTERDMShjMDksIHBDLCAodmFycykrMTEpOyBcCiAgICBM
Rl9NQUREKGMwOCwgYzEwLCBhbHBoYSk7IFwKICAgIExGX01BREQoYzA5LCBj
MTEsIGFscGhhKTsgXAogICAgUFJFRkVUQ0hfUk9XKHBDLCBMRl9ER0VNTV9Q
UkVGRVRDSCAqIExGX0RHRU1NX0JMT0NLKTsgXAogICAgTEZfU0RDMShhMCwg
cEMsICh2YXJzKSswKTsgXAogICAgTEZfU0RDMShhMSwgcEMsICh2YXJzKSsx
KTsgXAogICAgTEZfU0RDMShjMDAsIHBDLCAodmFycykrMik7IFwKICAgIExG
X1NEQzEoYzAxLCBwQywgKHZhcnMpKzMpOyBcCiAgICBMRl9TREMxKGMwMiwg
cEMsICh2YXJzKSs0KTsgXAogICAgTEZfU0RDMShjMDMsIHBDLCAodmFycykr
NSk7IFwKICAgIExGX1NEQzEoYzA0LCBwQywgKHZhcnMpKzYpOyBcCiAgICBM
Rl9TREMxKGMwNSwgcEMsICh2YXJzKSs3KTsgXAogICAgTEZfU0RDMShjMDYs
IHBDLCAodmFycykrOCk7IFwKICAgIExGX1NEQzEoYzA3LCBwQywgKHZhcnMp
KzkpOyBcCiAgICBMRl9TREMxKGMwOCwgcEMsICh2YXJzKSsxMCk7IFwKICAg
IExGX1NEQzEoYzA5LCBwQywgKHZhcnMpKzExKTsgXAp9CgojZGVmaW5lIFNU
T1JFX0NfQkVUQVgodmFycykgXAp7IFwKICAgIExGX0FTTSgiLmdsb2JsIFNU
T1JFX0NfQkVUQVgiKTsgXAogICAgTEZfTERDMShhMCwgcEMsICh2YXJzKSsw
KTsgXAogICAgTEZfTERDMShhMSwgcEMsICh2YXJzKSsxKTsgXAogICAgTEZf
TVVMKGEwLCBiZXRhKTsgXAogICAgTEZfTVVMKGExLCBiZXRhKTsgXAogICAg
TEZfTUFERChhMCwgYzAwLCBhbHBoYSk7IFwKICAgIExGX01BREQoYTEsIGMw
MSwgYWxwaGEpOyBcCiAgICBMRl9MREMxKGMwMCwgcEMsICh2YXJzKSsyKTsg
XAogICAgTEZfTERDMShjMDEsIHBDLCAodmFycykrMyk7IFwKICAgIExGX01V
TChjMDAsIGJldGEpOyBcCiAgICBMRl9NVUwoYzAxLCBiZXRhKTsgXAogICAg
TEZfTUFERChjMDAsIGMwMiwgYWxwaGEpOyBcCiAgICBMRl9NQUREKGMwMSwg
YzAzLCBhbHBoYSk7IFwKICAgIExGX0xEQzEoYzAyLCBwQywgKHZhcnMpKzQp
OyBcCiAgICBMRl9MREMxKGMwMywgcEMsICh2YXJzKSs1KTsgXAogICAgTEZf
TVVMKGMwMiwgYmV0YSk7IFwKICAgIExGX01VTChjMDMsIGJldGEpOyBcCiAg
ICBMRl9NQUREKGMwMiwgYzA0LCBhbHBoYSk7IFwKICAgIExGX01BREQoYzAz
LCBjMDUsIGFscGhhKTsgXAogICAgTEZfTERDMShjMDQsIHBDLCAodmFycykr
Nik7IFwKICAgIExGX0xEQzEoYzA1LCBwQywgKHZhcnMpKzcpOyBcCiAgICBM
Rl9NVUwoYzA0LCBiZXRhKTsgXAogICAgTEZfTVVMKGMwNSwgYmV0YSk7IFwK
ICAgIExGX01BREQoYzA0LCBjMDYsIGFscGhhKTsgXAogICAgTEZfTUFERChj
MDUsIGMwNywgYWxwaGEpOyBcCiAgICBMRl9MREMxKGMwNiwgcEMsICh2YXJz
KSs4KTsgXAogICAgTEZfTERDMShjMDcsIHBDLCAodmFycykrOSk7IFwKICAg
IExGX01VTChjMDYsIGJldGEpOyBcCiAgICBMRl9NVUwoYzA3LCBiZXRhKTsg
XAogICAgTEZfTUFERChjMDYsIGMwOCwgYWxwaGEpOyBcCiAgICBMRl9NQURE
KGMwNywgYzA5LCBhbHBoYSk7IFwKICAgIExGX0xEQzEoYzA4LCBwQywgKHZh
cnMpKzEwKTsgXAogICAgTEZfTERDMShjMDksIHBDLCAodmFycykrMTEpOyBc
CiAgICBMRl9NVUwoYzA4LCBiZXRhKTsgXAogICAgTEZfTVVMKGMwOSwgYmV0
YSk7IFwKICAgIExGX01BREQoYzA4LCBjMTAsIGFscGhhKTsgXAogICAgTEZf
TUFERChjMDksIGMxMSwgYWxwaGEpOyBcCiAgICBQUkVGRVRDSF9ST1cocEMs
IExGX0RHRU1NX1BSRUZFVENIICogTEZfREdFTU1fQkxPQ0spOyBcCiAgICBM
Rl9TREMxKGEwLCBwQywgKHZhcnMpKzApOyBcCiAgICBMRl9TREMxKGExLCBw
QywgKHZhcnMpKzEpOyBcCiAgICBMRl9TREMxKGMwMCwgcEMsICh2YXJzKSsy
KTsgXAogICAgTEZfU0RDMShjMDEsIHBDLCAodmFycykrMyk7IFwKICAgIExG
X1NEQzEoYzAyLCBwQywgKHZhcnMpKzQpOyBcCiAgICBMRl9TREMxKGMwMywg
cEMsICh2YXJzKSs1KTsgXAogICAgTEZfU0RDMShjMDQsIHBDLCAodmFycykr
Nik7IFwKICAgIExGX1NEQzEoYzA1LCBwQywgKHZhcnMpKzcpOyBcCiAgICBM
Rl9TREMxKGMwNiwgcEMsICh2YXJzKSs4KTsgXAogICAgTEZfU0RDMShjMDcs
IHBDLCAodmFycykrOSk7IFwKICAgIExGX1NEQzEoYzA4LCBwQywgKHZhcnMp
KzEwKTsgXAogICAgTEZfU0RDMShjMDksIHBDLCAodmFycykrMTEpOyBcCn0K
Ci8qIExvYWQgcm93IG9mIEIgYW5kIHByZWZldGNoIG5leHQgcm93IG9mIEIg
Ki8KI2RlZmluZSBMT0FEX0IoKSBcCnsgXAogICAgTEZfQVNNKCIuZ2xvYmwg
TE9BRF9CIik7IFwKICAgIExGX0xEQzEoYjAwLCBwQiwgMCk7IFwKICAgIExG
X0xEQzEoYjAxLCBwQiwgMSk7IFwKICAgIExGX0xEQzEoYjAyLCBwQiwgMik7
IFwKICAgIExGX0xEQzEoYjAzLCBwQiwgMyk7IFwKICAgIExGX0xEQzEoYjA0
LCBwQiwgNCk7IFwKICAgIExGX0xEQzEoYjA1LCBwQiwgNSk7IFwKICAgIExG
X0xEQzEoYjA2LCBwQiwgNik7IFwKICAgIExGX0xEQzEoYjA3LCBwQiwgNyk7
IFwKICAgIExGX0xEQzEoYjA4LCBwQiwgOCk7IFwKICAgIExGX0xEQzEoYjA5
LCBwQiwgOSk7IFwKICAgIExGX0xEQzEoYjEwLCBwQiwgMTApOyBcCiAgICBM
Rl9MREMxKGIxMSwgcEIsIDExKTsgXAogICAgUFJFRkVUQ0hfUk9XKHBCLCBL
Qik7IFwKICAgIHBCICs9IEtCOyBcCn0KCi8qIExvYWQgY29sdW1uIG9mIEEg
YW5kIG11bHRpcGx5IGJ5IGJ4ICovCiNkZWZpbmUgTVVMVF9DKGJ4LCB2YXJz
KSBcCnsgXAogICAgTEZfQVNNKCIuZ2xvYmwgTVVMVF9DIik7IFwKICAgIExG
X0xEQzEoYzAwLCBwQSwgMCpLQisodmFycykpOyBcCiAgICBMRl9MREMxKGMw
MSwgcEEsIDEqS0IrKHZhcnMpKTsgXAogICAgTEZfTVVMKGMwMCwgYngpOyBc
CiAgICBMRl9NVUwoYzAxLCBieCk7IFwKICAgIExGX0xEQzEoYzAyLCBwQSwg
MipLQisodmFycykpOyBcCiAgICBMRl9MREMxKGMwMywgcEEsIDMqS0IrKHZh
cnMpKTsgXAogICAgTEZfTVVMKGMwMiwgYngpOyBcCiAgICBMRl9NVUwoYzAz
LCBieCk7IFwKICAgIExGX0xEQzEoYzA0LCBwQSwgNCpLQisodmFycykpOyBc
CiAgICBMRl9MREMxKGMwNSwgcEEsIDUqS0IrKHZhcnMpKTsgXAogICAgTEZf
TVVMKGMwNCwgYngpOyBcCiAgICBMRl9NVUwoYzA1LCBieCk7IFwKICAgIExG
X0xEQzEoYzA2LCBwQSwgNipLQisodmFycykpOyBcCiAgICBMRl9MREMxKGMw
NywgcEEsIDcqS0IrKHZhcnMpKTsgXAogICAgTEZfTVVMKGMwNiwgYngpOyBc
CiAgICBMRl9NVUwoYzA3LCBieCk7IFwKICAgIExGX0xEQzEoYzA4LCBwQSwg
OCpLQisodmFycykpOyBcCiAgICBMRl9MREMxKGMwOSwgcEEsIDkqS0IrKHZh
cnMpKTsgXAogICAgTEZfTVVMKGMwOCwgYngpOyBcCiAgICBMRl9NVUwoYzA5
LCBieCk7IFwKICAgIExGX0xEQzEoYzEwLCBwQSwgMTAqS0IrKHZhcnMpKTsg
XAogICAgTEZfTERDMShjMTEsIHBBLCAxMSpLQisodmFycykpOyBcCiAgICBM
Rl9NVUwoYzEwLCBieCk7IFwKICAgIExGX01VTChjMTEsIGJ4KTsgXAp9Cgov
KiBMb2FkIGNvbHVtbiBvZiBBLCBtdWx0aXBseSBieSBieCBhbmQgYWRkIHRv
IHJvdyBvZiBDICovCiNkZWZpbmUgTUFERF9BKGJ4LCB2YXJzKSBcCnsgXAog
ICAgTEZfQVNNKCIuZ2xvYmwgTUFERF9BIik7IFwKICAgIExGX0xEQzEoYTAs
IHBBLCAwKktCKyh2YXJzKSk7IFwKICAgIExGX0xEQzEoYTEsIHBBLCAxKktC
Kyh2YXJzKSk7IFwKICAgIExGX01BREQoYzAwLCBhMCwgYngpOyBcCiAgICBM
Rl9NQUREKGMwMSwgYTEsIGJ4KTsgXAogICAgTEZfTERDMShhMCwgcEEsIDIq
S0IrKHZhcnMpKTsgXAogICAgTEZfTERDMShhMSwgcEEsIDMqS0IrKHZhcnMp
KTsgXAogICAgTEZfTUFERChjMDIsIGEwLCBieCk7IFwKICAgIExGX01BREQo
YzAzLCBhMSwgYngpOyBcCiAgICBMRl9MREMxKGEwLCBwQSwgNCpLQisodmFy
cykpOyBcCiAgICBMRl9MREMxKGExLCBwQSwgNSpLQisodmFycykpOyBcCiAg
ICBMRl9NQUREKGMwNCwgYTAsIGJ4KTsgXAogICAgTEZfTUFERChjMDUsIGEx
LCBieCk7IFwKICAgIExGX0xEQzEoYTAsIHBBLCA2KktCKyh2YXJzKSk7IFwK
ICAgIExGX0xEQzEoYTEsIHBBLCA3KktCKyh2YXJzKSk7IFwKICAgIExGX01B
REQoYzA2LCBhMCwgYngpOyBcCiAgICBMRl9NQUREKGMwNywgYTEsIGJ4KTsg
XAogICAgTEZfTERDMShhMCwgcEEsIDgqS0IrKHZhcnMpKTsgXAogICAgTEZf
TERDMShhMSwgcEEsIDkqS0IrKHZhcnMpKTsgXAogICAgTEZfTUFERChjMDgs
IGEwLCBieCk7IFwKICAgIExGX01BREQoYzA5LCBhMSwgYngpOyBcCiAgICBM
Rl9MREMxKGEwLCBwQSwgMTAqS0IrKHZhcnMpKTsgXAogICAgTEZfTERDMShh
MSwgcEEsIDExKktCKyh2YXJzKSk7IFwKICAgIExGX01BREQoYzEwLCBhMCwg
YngpOyBcCiAgICBMRl9NQUREKGMxMSwgYTEsIGJ4KTsgXAp9CgovKiBTYW1l
IGFzIE1BRERfQSBidXQgd2l0aCBwcmVmZXRjaCBvZiBuZXh0IGNvbHVtbiBv
ZiBBICovCiNkZWZpbmUgUE1BRF9BKGJ4LCB2YXJzKSBcCnsgXAogICAgTEZf
QVNNKCIuZ2xvYmwgUE1BRF9BIik7IFwKICAgIExGX0xEQzEoYTAsIHBBLCAw
KktCKyh2YXJzKSk7IFwKICAgIExGX0xEQzEoYTEsIHBBLCAxKktCKyh2YXJz
KSk7IFwKICAgIExGX0RHRU1NX1BSRUZfTE9BRChwQSwgKExGX0RHRU1NX1BS
RUZFVENIKkxGX0RHRU1NX0JMT0NLKzApKktCKyh2YXJzKSk7IFwKICAgIExG
X0RHRU1NX1BSRUZfTE9BRChwQSwgKExGX0RHRU1NX1BSRUZFVENIKkxGX0RH
RU1NX0JMT0NLKzEpKktCKyh2YXJzKSk7IFwKICAgIExGX01BREQoYzAwLCBh
MCwgYngpOyBcCiAgICBMRl9NQUREKGMwMSwgYTEsIGJ4KTsgXAogICAgTEZf
TERDMShhMCwgcEEsIDIqS0IrKHZhcnMpKTsgXAogICAgTEZfTERDMShhMSwg
cEEsIDMqS0IrKHZhcnMpKTsgXAogICAgTEZfREdFTU1fUFJFRl9MT0FEKHBB
LCAoTEZfREdFTU1fUFJFRkVUQ0gqTEZfREdFTU1fQkxPQ0srMikqS0IrKHZh
cnMpKTsgXAogICAgTEZfREdFTU1fUFJFRl9MT0FEKHBBLCAoTEZfREdFTU1f
UFJFRkVUQ0gqTEZfREdFTU1fQkxPQ0srMykqS0IrKHZhcnMpKTsgXAogICAg
TEZfTUFERChjMDIsIGEwLCBieCk7IFwKICAgIExGX01BREQoYzAzLCBhMSwg
YngpOyBcCiAgICBMRl9MREMxKGEwLCBwQSwgNCpLQisodmFycykpOyBcCiAg
ICBMRl9MREMxKGExLCBwQSwgNSpLQisodmFycykpOyBcCiAgICBMRl9ER0VN
TV9QUkVGX0xPQUQocEEsIChMRl9ER0VNTV9QUkVGRVRDSCpMRl9ER0VNTV9C
TE9DSys0KSpLQisodmFycykpOyBcCiAgICBMRl9ER0VNTV9QUkVGX0xPQUQo
cEEsIChMRl9ER0VNTV9QUkVGRVRDSCpMRl9ER0VNTV9CTE9DSys1KSpLQiso
dmFycykpOyBcCiAgICBMRl9NQUREKGMwNCwgYTAsIGJ4KTsgXAogICAgTEZf
TUFERChjMDUsIGExLCBieCk7IFwKICAgIExGX0xEQzEoYTAsIHBBLCA2KktC
Kyh2YXJzKSk7IFwKICAgIExGX0xEQzEoYTEsIHBBLCA3KktCKyh2YXJzKSk7
IFwKICAgIExGX0RHRU1NX1BSRUZfTE9BRChwQSwgKExGX0RHRU1NX1BSRUZF
VENIKkxGX0RHRU1NX0JMT0NLKzYpKktCKyh2YXJzKSk7IFwKICAgIExGX0RH
RU1NX1BSRUZfTE9BRChwQSwgKExGX0RHRU1NX1BSRUZFVENIKkxGX0RHRU1N
X0JMT0NLKzcpKktCKyh2YXJzKSk7IFwKICAgIExGX01BREQoYzA2LCBhMCwg
YngpOyBcCiAgICBMRl9NQUREKGMwNywgYTEsIGJ4KTsgXAogICAgTEZfTERD
MShhMCwgcEEsIDgqS0IrKHZhcnMpKTsgXAogICAgTEZfTERDMShhMSwgcEEs
IDkqS0IrKHZhcnMpKTsgXAogICAgTEZfREdFTU1fUFJFRl9MT0FEKHBBLCAo
TEZfREdFTU1fUFJFRkVUQ0gqTEZfREdFTU1fQkxPQ0srOCkqS0IrKHZhcnMp
KTsgXAogICAgTEZfREdFTU1fUFJFRl9MT0FEKHBBLCAoTEZfREdFTU1fUFJF
RkVUQ0gqTEZfREdFTU1fQkxPQ0srOSkqS0IrKHZhcnMpKTsgXAogICAgTEZf
TUFERChjMDgsIGEwLCBieCk7IFwKICAgIExGX01BREQoYzA5LCBhMSwgYngp
OyBcCiAgICBMRl9MREMxKGEwLCBwQSwgMTAqS0IrKHZhcnMpKTsgXAogICAg
TEZfTERDMShhMSwgcEEsIDExKktCKyh2YXJzKSk7IFwKICAgIExGX0RHRU1N
X1BSRUZfTE9BRChwQSwgKExGX0RHRU1NX1BSRUZFVENIKkxGX0RHRU1NX0JM
T0NLKzEwKSpLQisodmFycykpOyBcCiAgICBMRl9ER0VNTV9QUkVGX0xPQUQo
cEEsIChMRl9ER0VNTV9QUkVGRVRDSCpMRl9ER0VNTV9CTE9DSysxMSkqS0Ir
KHZhcnMpKTsgXAogICAgTEZfTUFERChjMTAsIGEwLCBieCk7IFwKICAgIExG
X01BREQoYzExLCBhMSwgYngpOyBcCn0KCgoKLyoKICogIE5PVEVTCiAqICAg
ICAgVGhlc2UgZnVuY3Rpb25zIGFzc3VtZSB0aGUgZGF0YSBzZXQgZml0cyBp
biBMMSBjYWNoZSwKICogICAgICB0aGVyZWZvcmUgZWFjaCB2YXJpYWJsZSBu
ZWVkIG9ubHkgYmUgcHJlZmV0Y2hlZCBvbmNlLgogKgogKiAgT1VUUFVUCiAq
ICAgICAgQyArPSBhbHBoYSAqIEEoVCkgKiBCCiAqLwoKI2RlZmluZSBwQiAg
QgojZGVmaW5lIHBDICBDCgovKiAgMSBGUCByZWdpc3RlcnMgKi8KLyogIDQg
R1AgcmVnaXN0ZXJzICovCiNpZiAgIGRlZmluZWQoQkVUQTApCnN0YXRpYyB2
b2lkIGZpcnN0X2JldGEwKGNvbnN0IFRZUEUgYWxwaGEsIGNvbnN0IFRZUEUg
KkEsIGNvbnN0IFRZUEUgKkIsIFRZUEUgKkMsIGNvbnN0IGludCBsZGNfTSwg
Y29uc3QgVFlQRSAqcEVuZEIpCnsKICAgIC8qIDI2IEZQIHJlZ2lzdGVycyAq
LwogICAgcmVnaXN0ZXIgVFlQRSAgICAgICAgICAgYTAsYTE7CiAgICByZWdp
c3RlciBUWVBFICAgICAgICAgICBiMDAsYjAxLGIwMixiMDMsYjA0LGIwNSxi
MDYsYjA3LGIwOCxiMDksYjEwLGIxMTsKICAgIHJlZ2lzdGVyIFRZUEUgICAg
ICAgICAgIGMwMCxjMDEsYzAyLGMwMyxjMDQsYzA1LGMwNixjMDcsYzA4LGMw
OSxjMTAsYzExOwoKICAgIC8qICAzIEdQIHJlZ2lzdGVycyAqLwogICAgcmVn
aXN0ZXIgY29uc3QgVFlQRSAqICAgcEE7CiAgICByZWdpc3RlciBjb25zdCBU
WVBFICogICBwRW5kQzsKCiAgICAvKiBQcmVmZXRjaCBmaXJzdCByb3cgb2Yg
QiAqLwogICAgUFJFRkVUQ0hfUk9XKHBCLCAwKTsKCiAgICAvKiBQcmVmZXRj
aCBmaXJzdCBibG9jayBvZiBBICovCiAgICBwQSA9IEE7CiAgICBQUkVGRVRD
SF9DT0wocEEsICAwKTsKICAgIFBSRUZFVENIX0NPTChwQSwgIDQpOwogICAg
UFJFRkVUQ0hfQ09MKHBBLCAgOCk7CgogICAgLyogUHJlZmV0Y2ggZmlyc3Qg
cm93IG9mIEMgKi8KICAgIFBSRUZFVENIX1JPVyhwQywgMCk7CgogICAgLyog
Zm9yIGogPSAwICovCiAgICB7CiAgICAgICAgcEVuZEMgPSAmcENbTUJdOwog
ICAgICAgIExPQURfQigpOwogICAgICAgIHdoaWxlIChwQyA8IHBFbmRDKSAv
KiBmb3IgaSA9IDAuLk0gc3RlcCA0ICovCiAgICAgICAgewogICAgICAgICAg
ICBNVUxUX0MoYjAwLCAgMCk7CiAgICAgICAgICAgIE1BRERfQShiMDEsICAx
KTsKICAgICAgICAgICAgTUFERF9BKGIwMiwgIDIpOwogICAgICAgICAgICBQ
TUFEX0EoYjAzLCAgMyk7CiAgICAgICAgICAgIE1BRERfQShiMDQsICA0KTsK
ICAgICAgICAgICAgTUFERF9BKGIwNSwgIDUpOwogICAgICAgICAgICBNQURE
X0EoYjA2LCAgNik7CiAgICAgICAgICAgIFBNQURfQShiMDcsICA3KTsKICAg
ICAgICAgICAgTUFERF9BKGIwOCwgIDgpOwogICAgICAgICAgICBNQUREX0Eo
YjA5LCAgOSk7CiAgICAgICAgICAgIE1BRERfQShiMTAsIDEwKTsKICAgICAg
ICAgICAgUE1BRF9BKGIxMSwgMTEpOwogICAgICAgICAgICBwQSArPSBMRl9E
R0VNTV9CTE9DSyAqIEtCOwogICAgICAgICAgICBTVE9SRV9DX0JFVEEwKDAp
OwogICAgICAgICAgICBwQyArPSBMRl9ER0VNTV9CTE9DSzsKICAgICAgICB9
IC8qIGZvciBpICovCiAgICAgICAgcEMgKz0gbGRjX007IC8qIGxkYyAtIE0g
Ki8KICAgIH0KCiAgICB3aGlsZSAocEIgPCBwRW5kQikgLyogZm9yIGogPSAx
Li5OICovCiAgICB7CiAgICAgICAgcEVuZEMgPSAmcENbTUJdOwogICAgICAg
IHBBID0gQTsKICAgICAgICBMT0FEX0IoKQogICAgICAgIHdoaWxlIChwQyA8
IHBFbmRDKSAvKiBmb3IgaSA9IDAuLk0gc3RlcCA0ICovCiAgICAgICAgewog
ICAgICAgICAgICBNVUxUX0MoYjAwLCAgMCk7CiAgICAgICAgICAgIE1BRERf
QShiMDEsICAxKTsKICAgICAgICAgICAgTUFERF9BKGIwMiwgIDIpOwogICAg
ICAgICAgICBNQUREX0EoYjAzLCAgMyk7CiAgICAgICAgICAgIE1BRERfQShi
MDQsICA0KTsKICAgICAgICAgICAgTUFERF9BKGIwNSwgIDUpOwogICAgICAg
ICAgICBNQUREX0EoYjA2LCAgNik7CiAgICAgICAgICAgIE1BRERfQShiMDcs
ICA3KTsKICAgICAgICAgICAgTUFERF9BKGIwOCwgIDgpOwogICAgICAgICAg
ICBNQUREX0EoYjA5LCAgOSk7CiAgICAgICAgICAgIE1BRERfQShiMTAsIDEw
KTsKICAgICAgICAgICAgTUFERF9BKGIxMSwgMTEpOwogICAgICAgICAgICBw
QSArPSBMRl9ER0VNTV9CTE9DSyAqIEtCOwogICAgICAgICAgICBTVE9SRV9D
X0JFVEEwKDApOwogICAgICAgICAgICBwQyArPSBMRl9ER0VNTV9CTE9DSzsK
ICAgICAgICB9IC8qIGZvciBpICovCiAgICAgICAgcEMgKz0gbGRjX007IC8q
IGxkYyAtIE0gKi8KICAgIH0gLyogZm9yIGogKi8KfSAvKiBmaXJzdF9iZXRh
MCgpICovCiNlbmRpZiAvKiBCRVRBMCAqLwoKLyogIDIgRlAgcmVnaXN0ZXJz
ICovCi8qICA0IEdQIHJlZ2lzdGVycyAqLwojaWYgICBkZWZpbmVkKEJFVEFY
KQpzdGF0aWMgdm9pZCBmaXJzdF9iZXRheChjb25zdCBUWVBFIGFscGhhLCBj
b25zdCBUWVBFIGJldGEsIGNvbnN0IFRZUEUgKkEsIGNvbnN0IFRZUEUgKkIs
IFRZUEUgKkMsIGNvbnN0IGludCBsZGNfTSwgY29uc3QgVFlQRSAqcEVuZEIp
CnsKICAgIC8qIDI2IEZQIHJlZ2lzdGVycyAqLwogICAgcmVnaXN0ZXIgVFlQ
RSAgICAgICAgICAgYTAsYTE7CiAgICByZWdpc3RlciBUWVBFICAgICAgICAg
ICBiMDAsYjAxLGIwMixiMDMsYjA0LGIwNSxiMDYsYjA3LGIwOCxiMDksYjEw
LGIxMTsKICAgIHJlZ2lzdGVyIFRZUEUgICAgICAgICAgIGMwMCxjMDEsYzAy
LGMwMyxjMDQsYzA1LGMwNixjMDcsYzA4LGMwOSxjMTAsYzExOwoKICAgIC8q
ICAzIEdQIHJlZ2lzdGVycyAqLwogICAgcmVnaXN0ZXIgY29uc3QgVFlQRSAq
ICAgcEE7CiAgICByZWdpc3RlciBjb25zdCBUWVBFICogICBwRW5kQzsKCiAg
ICAvKiBQcmVmZXRjaCBmaXJzdCByb3cgb2YgQiAqLwogICAgUFJFRkVUQ0hf
Uk9XKHBCLCAwKTsKCiAgICAvKiBQcmVmZXRjaCBmaXJzdCBibG9jayBvZiBB
ICovCiAgICBwQSA9IEE7CiAgICBQUkVGRVRDSF9DT0wocEEsICAwKTsKICAg
IFBSRUZFVENIX0NPTChwQSwgIDQpOwogICAgUFJFRkVUQ0hfQ09MKHBBLCAg
OCk7CgogICAgLyogUHJlZmV0Y2ggZmlyc3Qgcm93IG9mIEMgKi8KICAgIFBS
RUZFVENIX1JPVyhwQywgMCk7CgogICAgLyogZm9yIGogPSAwICovCiAgICB7
CiAgICAgICAgcEVuZEMgPSAmcENbTUJdOwogICAgICAgIExPQURfQigpOwog
ICAgICAgIHdoaWxlIChwQyA8IHBFbmRDKSAvKiBmb3IgaSA9IDAuLk0gc3Rl
cCA0ICovCiAgICAgICAgewogICAgICAgICAgICBNVUxUX0MoYjAwLCAgMCk7
CiAgICAgICAgICAgIE1BRERfQShiMDEsICAxKTsKICAgICAgICAgICAgTUFE
RF9BKGIwMiwgIDIpOwogICAgICAgICAgICBQTUFEX0EoYjAzLCAgMyk7CiAg
ICAgICAgICAgIE1BRERfQShiMDQsICA0KTsKICAgICAgICAgICAgTUFERF9B
KGIwNSwgIDUpOwogICAgICAgICAgICBNQUREX0EoYjA2LCAgNik7CiAgICAg
ICAgICAgIFBNQURfQShiMDcsICA3KTsKICAgICAgICAgICAgTUFERF9BKGIw
OCwgIDgpOwogICAgICAgICAgICBNQUREX0EoYjA5LCAgOSk7CiAgICAgICAg
ICAgIE1BRERfQShiMTAsIDEwKTsKICAgICAgICAgICAgUE1BRF9BKGIxMSwg
MTEpOwogICAgICAgICAgICBwQSArPSBMRl9ER0VNTV9CTE9DSyAqIEtCOwog
ICAgICAgICAgICBTVE9SRV9DX0JFVEFYKDApOwogICAgICAgICAgICBwQyAr
PSBMRl9ER0VNTV9CTE9DSzsKICAgICAgICB9IC8qIGZvciBpICovCiAgICAg
ICAgcEMgKz0gbGRjX007IC8qIGxkYyAtIE0gKi8KICAgIH0KCiAgICB3aGls
ZSAocEIgPCBwRW5kQikgLyogZm9yIGogPSAxLi5OICovCiAgICB7CiAgICAg
ICAgcEVuZEMgPSAmcENbTUJdOwogICAgICAgIHBBID0gQTsKICAgICAgICBM
T0FEX0IoKQogICAgICAgIHdoaWxlIChwQyA8IHBFbmRDKSAvKiBmb3IgaSA9
IDAuLk0gc3RlcCA0ICovCiAgICAgICAgewogICAgICAgICAgICBNVUxUX0Mo
YjAwLCAgMCk7CiAgICAgICAgICAgIE1BRERfQShiMDEsICAxKTsKICAgICAg
ICAgICAgTUFERF9BKGIwMiwgIDIpOwogICAgICAgICAgICBNQUREX0EoYjAz
LCAgMyk7CiAgICAgICAgICAgIE1BRERfQShiMDQsICA0KTsKICAgICAgICAg
ICAgTUFERF9BKGIwNSwgIDUpOwogICAgICAgICAgICBNQUREX0EoYjA2LCAg
Nik7CiAgICAgICAgICAgIE1BRERfQShiMDcsICA3KTsKICAgICAgICAgICAg
TUFERF9BKGIwOCwgIDgpOwogICAgICAgICAgICBNQUREX0EoYjA5LCAgOSk7
CiAgICAgICAgICAgIE1BRERfQShiMTAsIDEwKTsKICAgICAgICAgICAgTUFE
RF9BKGIxMSwgMTEpOwogICAgICAgICAgICBwQSArPSBMRl9ER0VNTV9CTE9D
SyAqIEtCOwogICAgICAgICAgICBTVE9SRV9DX0JFVEFYKDApOwogICAgICAg
ICAgICBwQyArPSBMRl9ER0VNTV9CTE9DSzsKICAgICAgICB9IC8qIGZvciBp
ICovCiAgICAgICAgcEMgKz0gbGRjX007IC8qIGxkYyAtIE0gKi8KICAgIH0g
LyogZm9yIGogKi8KfSAvKiBmaXJzdF9iZXRheCgpICovCiNlbmRpZiAvKiBC
RVRBWCAqLwoKLyogIDEgRlAgcmVnaXN0ZXJzICovCi8qICA0IEdQIHJlZ2lz
dGVycyAqLwpzdGF0aWMgdm9pZCBuZXh0KGNvbnN0IFRZUEUgYWxwaGEsIGNv
bnN0IFRZUEUgKkEsIGNvbnN0IFRZUEUgKkIsIFRZUEUgKkMsIGNvbnN0IGlu
dCBsZGNfTSwgY29uc3QgVFlQRSAqcEVuZEIpCnsKICAgIC8qIDI2IEZQIHJl
Z2lzdGVycyAqLwogICAgcmVnaXN0ZXIgVFlQRSAgICAgICAgICAgYTAsYTE7
CiAgICByZWdpc3RlciBUWVBFICAgICAgICAgICBiMDAsYjAxLGIwMixiMDMs
YjA0LGIwNSxiMDYsYjA3LGIwOCxiMDksYjEwLGIxMTsKICAgIHJlZ2lzdGVy
IFRZUEUgICAgICAgICAgIGMwMCxjMDEsYzAyLGMwMyxjMDQsYzA1LGMwNixj
MDcsYzA4LGMwOSxjMTAsYzExOwoKICAgIC8qICAzIEdQIHJlZ2lzdGVycyAq
LwogICAgcmVnaXN0ZXIgY29uc3QgVFlQRSAqICAgcEE7CiAgICByZWdpc3Rl
ciBjb25zdCBUWVBFICogICBwRW5kQzsKCiAgICAvKiBQcmVmZXRjaCBmaXJz
dCByb3cgb2YgQiAqLwogICAgUFJFRkVUQ0hfUk9XKHBCLCAwKTsKCiAgICAv
KiBQcmVmZXRjaCBmaXJzdCBibG9jayBvZiBBICovCiAgICBwQSA9IEE7CiAg
ICBQUkVGRVRDSF9DT0wocEEsICAwKTsKICAgIFBSRUZFVENIX0NPTChwQSwg
IDQpOwogICAgUFJFRkVUQ0hfQ09MKHBBLCAgOCk7CgogICAgLyogUHJlZmV0
Y2ggZmlyc3Qgcm93IG9mIEMgKi8KICAgIFBSRUZFVENIX1JPVyhwQywgMCk7
CgogICAgLyogZm9yIGogPSAwICovCiAgICB7CiAgICAgICAgcEVuZEMgPSAm
cENbTUJdOwogICAgICAgIExPQURfQigpOwogICAgICAgIHdoaWxlIChwQyA8
IHBFbmRDKSAvKiBmb3IgaSA9IDAuLk0gc3RlcCA0ICovCiAgICAgICAgewog
ICAgICAgICAgICBNVUxUX0MoYjAwLCAgMCk7CiAgICAgICAgICAgIE1BRERf
QShiMDEsICAxKTsKICAgICAgICAgICAgTUFERF9BKGIwMiwgIDIpOwogICAg
ICAgICAgICBQTUFEX0EoYjAzLCAgMyk7CiAgICAgICAgICAgIE1BRERfQShi
MDQsICA0KTsKICAgICAgICAgICAgTUFERF9BKGIwNSwgIDUpOwogICAgICAg
ICAgICBNQUREX0EoYjA2LCAgNik7CiAgICAgICAgICAgIFBNQURfQShiMDcs
ICA3KTsKICAgICAgICAgICAgTUFERF9BKGIwOCwgIDgpOwogICAgICAgICAg
ICBNQUREX0EoYjA5LCAgOSk7CiAgICAgICAgICAgIE1BRERfQShiMTAsIDEw
KTsKICAgICAgICAgICAgUE1BRF9BKGIxMSwgMTEpOwogICAgICAgICAgICBw
QSArPSBMRl9ER0VNTV9CTE9DSyAqIEtCOwogICAgICAgICAgICBTVE9SRV9D
X0JFVEExKDApOwogICAgICAgICAgICBwQyArPSBMRl9ER0VNTV9CTE9DSzsK
ICAgICAgICB9IC8qIGZvciBpICovCiAgICAgICAgcEMgKz0gbGRjX007IC8q
IGxkYyAtIE0gKi8KICAgIH0KCiAgICB3aGlsZSAocEIgPCBwRW5kQikgLyog
Zm9yIGogPSAxLi5OICovCiAgICB7CiAgICAgICAgcEVuZEMgPSAmcENbTUJd
OwogICAgICAgIHBBID0gQTsKICAgICAgICBMT0FEX0IoKQogICAgICAgIHdo
aWxlIChwQyA8IHBFbmRDKSAvKiBmb3IgaSA9IDAuLk0gc3RlcCA0ICovCiAg
ICAgICAgewogICAgICAgICAgICBNVUxUX0MoYjAwLCAgMCk7CiAgICAgICAg
ICAgIE1BRERfQShiMDEsICAxKTsKICAgICAgICAgICAgTUFERF9BKGIwMiwg
IDIpOwogICAgICAgICAgICBNQUREX0EoYjAzLCAgMyk7CiAgICAgICAgICAg
IE1BRERfQShiMDQsICA0KTsKICAgICAgICAgICAgTUFERF9BKGIwNSwgIDUp
OwogICAgICAgICAgICBNQUREX0EoYjA2LCAgNik7CiAgICAgICAgICAgIE1B
RERfQShiMDcsICA3KTsKICAgICAgICAgICAgTUFERF9BKGIwOCwgIDgpOwog
ICAgICAgICAgICBNQUREX0EoYjA5LCAgOSk7CiAgICAgICAgICAgIE1BRERf
QShiMTAsIDEwKTsKICAgICAgICAgICAgTUFERF9BKGIxMSwgMTEpOwogICAg
ICAgICAgICBwQSArPSBMRl9ER0VNTV9CTE9DSyAqIEtCOwogICAgICAgICAg
ICBTVE9SRV9DX0JFVEExKDApOwogICAgICAgICAgICBwQyArPSBMRl9ER0VN
TV9CTE9DSzsKICAgICAgICB9IC8qIGZvciBpICovCiAgICAgICAgcEMgKz0g
bGRjX007IC8qIGxkYyAtIE0gKi8KICAgIH0gLyogZm9yIGogKi8KfSAvKiBu
ZXh0KCkgKi8KCgoKdm9pZCBBVExfVVNFUk1NKGNvbnN0IGludCBNLCBjb25z
dCBpbnQgTiwgY29uc3QgaW50IEssCiAgICAgICAgICAgICAgICBjb25zdCBU
WVBFIGFscGhhLAogICAgICAgICAgICAgICAgY29uc3QgVFlQRSAqQSwgY29u
c3QgaW50IGxkYSwKICAgICAgICAgICAgICAgIGNvbnN0IFRZUEUgKkIsIGNv
bnN0IGludCBsZGIsCiAgICAgICAgICAgICAgICBjb25zdCBUWVBFIGJldGEs
CiAgICAgICAgICAgICAgICAgICAgICBUWVBFICpDLCBjb25zdCBpbnQgbGRj
KQp7CiAgICByZWdpc3RlciBpbnQgbGRjX00gPSBsZGMgLSBNOwogICAgcmVn
aXN0ZXIgY29uc3QgVFlQRSAqcEVuZEIgPSAmQltLQiAqIE5dOwogICAgcmVn
aXN0ZXIgaW50IGs7CgojaWYgICBkZWZpbmVkKEJFVEEwKQogICAgZmlyc3Rf
YmV0YTAoYWxwaGEsIEEsIEIsIEMsIGxkY19NLCBwRW5kQik7CiNlbGlmIGRl
ZmluZWQoQkVUQTEpCiAgICBuZXh0KGFscGhhLCBBLCBCLCBDLCBsZGNfTSwg
cEVuZEIpOwojZWxzZQogICAgZmlyc3RfYmV0YXgoYWxwaGEsIGJldGEsIEEs
IEIsIEMsIGxkY19NLCBwRW5kQik7CiNlbmRpZgoKICAgIGZvciAoayA9IExG
X0RHRU1NX0JMT0NLOyBrIDwgSzsgayArPSBMRl9ER0VNTV9CTE9DSykKICAg
IHsKICAgICAgICBuZXh0KGFscGhhLCAmQVtrXSwgJkJba10sIEMsIGxkY19N
LCBwRW5kQik7CiAgICB9Cn0KCg==

--0-1897457798-1157578896=:54718--
