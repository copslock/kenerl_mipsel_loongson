Received:  by oss.sgi.com id <S42207AbQJKWmc>;
	Wed, 11 Oct 2000 15:42:32 -0700
Received: from hq.fsmlabs.com ([209.155.42.197]:55562 "EHLO hq.fsmlabs.com")
	by oss.sgi.com with ESMTP id <S42239AbQJKWmO>;
	Wed, 11 Oct 2000 15:42:14 -0700
Received: (from cort@localhost)
	by hq.fsmlabs.com (8.9.3/8.9.3) id QAA30529;
	Wed, 11 Oct 2000 16:38:27 -0600
Date:   Wed, 11 Oct 2000 16:38:27 -0600
From:   Cort Dougan <cort@fsmlabs.com>
To:     Florian Lohoff <flo@rfc822.org>
Cc:     linux-mips@oss.sgi.com, linux-mips@fnet.fr,
        Ralf Baechle <ralf@uni-koblenz.de>
Subject: Re: modutils bug?  'if' clause executes incorrectly
Message-ID: <20001011163827.H28328@hq.fsmlabs.com>
References: <20001010224317.I733@hq.fsmlabs.com> <20001012002619.B678@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=WYTEVAkct0FjGQmd
X-Mailer: Mutt 0.95.4us
In-Reply-To: <20001012002619.B678@paradigm.rfc822.org>; from Florian Lohoff on Thu, Oct 12, 2000 at 12:26:19AM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii

} On Tue, Oct 10, 2000 at 10:43:17PM -0600, Cort Dougan wrote:
} > if A
} >   B
} > else
} >   C
} > 
} > in the order A, C, B when A is false and correctly (A, B) when A is true.
} > 
} > This is with GCC version egcs-2.90.29 980515 (egcs-1.0.3 release) and
} > binutils 2.8.1 (with BFD 2.8.1).
} > 
} > The asm in this routine looks good and I can keep the code from failing by
} > removing the request_irq() and replacing it with something else that
} > doesn't call into the kernel.  I can't reproduce this in user-code or in
} > kernel code.
} > 
} > Does anyone have any suggestions?  Perhaps a suggestion for modutils
} > version?
} 
} Please send the resulting asm code - I hear someone whispering
} "Branch delay slot".

.c and gzip'd .s attached.

Compiled with: mips-linux-gcc -v -G 0 -mno-abicalls -fno-pic -ffixed-8__
-D__KERNEL__ -DMODULE -D_LOOSE_KERNEL_NAMES -O2   -c 
-fomit-frame-pointer -pipe -mcpu=r8000 -mips2 -mlong-calls
-I/sys/linux/include -I/sys/rtlinux/include -I/sys/rtlinux/include/compat
-I/sys/rtlinux/include/posix -Wall -Wstrict-prototypes -g -D__RTL__
-D__KERNEL__ -DMODULE -D_LOOSE_KERNEL_NAMES -O2   -c -o bug.o main/bug.c
--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="bug.c"

#include <linux/kernel.h>
#include <linux/version.h>
#include <linux/errno.h>
#include <linux/malloc.h>
#include <linux/timex.h>
#include <linux/spinlock.h>
#include <linux/module.h>
#include <linux/interrupt.h>
#include <linux/console.h>
#include <linux/irq.h>
#include <linux/config.h>

#include <asm/uaccess.h>
#include <asm/system.h>
#include <asm/irq.h>
#include <asm/segment.h>
#include <asm/ptrace.h>
int var;
MODULE_PARM(var, "i");

void foo(void)
{
}

int init_module(void)
{
	int debug, i;
#define RTL_NR_IRQS 32
	for (i = RTL_NR_IRQS - 1; i > 15; i--)
	{
		printk("A\n");
		debug = request_irq (i, foo, 0, "blah", 0);
		printk("debug %d \n", debug);
		if ( debug )
		{
			printk("B\n");
			continue;
		}
		else
		{
			printk("C\n");
			return debug;
		}
	}
	return 0;
}

void cleanup_module(void)
{
}

--WYTEVAkct0FjGQmd
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="bug.s.gz"
Content-Transfer-Encoding: base64

H4sICEvr5DkCA2J1Zy5zAJRbbY+kOJL+3P0r8vp2pN1RZQ02YEyW+HKzc6OVVrPSba/uy0mI
BDKTKxIYXqqr9tffE34Bk0VW7/VI3elwOByO9zCeT4+nqi4/sd2X43R+zL98/vT4UvZD1Taf
vnjs0WNfPu/+fffrb//Y/bwzE7vynA97/hh7jzzexdILWbj7owJiwaO/68u6zIbyT7s/Xqtu
2NdVM73+aZe31w5bFbvj2x167FGIHYvj2PNZMFNkj3ym+EjMtN2IVcOuy4ahLA673f566nyO
f87qn1/xq2n32bHKs7oeMMq7Keml53n4DY44Udlf67Y57w3Kebf/G5b+N0b4exj7Kh/3Xd+O
7fjWlUA4gWJX5fhxql7LYi8VjVN7rcb9qc+u5b5rq2Yse5fDssmOtWbxVJSnsgdSt7kKwHwo
MVPX7bf9/07XbtAbEHR4rrr9sW7zZ2KkfO3KZqheyj1tc63+menN9qfx0pdZ4a7GQcrmPF72
fVlMeQlIV5bdpa3p56nt83J/La/0e2pyIrPHfhhWDZRWahrPWLEfRuyS73NsNNJWJDYcZ8he
lHC6PAdKP0FofTlOfaMOXGdvkNSxz5r8omn1ZT+pPfbZCafe162ShwbTgM5EfOcXMFyX+6oZ
GnuWFYwTE+312tJWMKRjS0QHOsu5mcjmnpVU+/J8bV/MUbK6yoY96OTPNOrP07Vsxr0Ck/mo
v12zuJZH13y03SgL+nzOc55am348fE5T7DsD0vzw+RFCOw67Lz8Nb8NP/ajc4KcvD8zzHui/
P/x1LF9Hb0a7ZlXzk3bCdzifHunfz2a4kIbtHEaW9Oxpz1kQBdIXgXyaf0ZPIMWlIrVslF+y
/jDypOdP3hPj20gkhZ0i7ye9//8hP8E4zw38XK0Okj7ANnt2f5f1gjDpw+8sWHgTdHQP0tr4
8+RFW3++Q3bNTKTor6myf53scGn7UVOSsKCnvc8jIZ/o748WrHmIkz6GQEQY+uH2Io2s1co8
sEzi4/Kubmf6ZgkZEI75xMPtDU51m5GdcZIGaXMLqWgnxDpg+YQl72ApGc+owUeo5Ep1+aqF
wMJkkIhu9YEByedP1TU747fPafDhess92Yq4y77Fnnkj1UffZW59HiiZybtrXtqqAFKcsHhr
WgWQPH3J0roawDD3Es6SH7nF5bGDvDt85Twp07RpU8pQaV4jGx727CFNaR8X6AFGSeZc9i6Y
UMkAXBgHrGwQFfusduE+4McWaSNrXHAAsElgLjgEuKd0VzZ56U4ITLSn01COLjRS6OsNJTGn
ZeyCY4Btqlqdhc54LcdLuzo5Y4p03vZrMB1zam5p0CGzvs/eVlA6I9UDzXkFpjPenIPR8aia
WgHpdHV2s1o+bFvIrHs/4Z7FYJK53v42VM2phf6DZBDBRDVACQUpr4CpF9BimGS9Rw79FJKH
xOIJdUxWo+CAbogoUJEZSwMQau0AWygLA4qVXx2nE7SoQZwHBFKEhm9ZR6BQWEoWIhVtFE45
Kcvn4N5sfqnOF2D4IbdrLEQqwqhDSCcjjCpgim56OnBhThI98YcgkA8i2Hb2Z1qeZ0jtKYkv
SrhMXgcHOhxmcfKV06FMaMo6PRWkTiyNE99LBqCeiiE9ViOMnxkmfAZ5goDHHS58uUUOAfaS
NUVNjoEUyhPfT370g+S0+H7AthY+l29qRZiwGTHYQizKF4UoknAxlC3EikIEECMHMd5CvLaF
kp4vF0zubWFSdfisUGMHdfM8cHdCDLzEnxE3FdBR0AIicxD9zfN0+YzMHeRNKU0G0XcQwy3E
s0EMHESxrdl/KikFYRLMmNEm5owqFmXyTR11Y19URlKRg7ypJ3J4hSkXXv1NPQ3TgODXwJAJ
PXbQN3WVU4tBqKGjLX9TW0VWFMq0Q0df/qa+8hmVI6HNuPfUxYTC9ZPZUXxxR2EGNXBQoztU
fa5QQ4dZeYeqQRUO6qYa2rqw5hVGSTBjB949bGNjoUyC4OMoUBu3CeNEfBwGToMmKrxEMNRI
LyiRBDcBiz1RXnBjZuAeZbIeL3wnNqyVOEhMBwnz7kSEieYRrNidMDAwAQSRyDtOPan5aFHh
jR8PPse8dHxibQ2Tmo/v+iJSJMp4bxHjjd4nNc+SaFPZU/r7lCn5RnxBCVyXIAFFviOg0BUA
iScKHPGEq7V0+ChchBO6h1eiicQimtCNXEowkRMsQvfgSiyRXMQSusfWQnFsS7izSiTSW84r
XJEU1yy1Hi3ZYjeRqxebTSVcfmafrdoFnb4kAvPMBXMlZ9KWRECONlO3NV4Jp5ab1junKQln
XthwZWz8TMKBl3rLFbPJNBKinCXN3KPOkVAiFy4orjJMTo8RVbdz9SpOxywJ4s1MbaJNzJMw
3EymJsDEcGex6W9zfI2DJNxOnXNcjcMkDDaTpo1OMWqPeNspTOaLIddw0zHm5BhDsjOzoStZ
JynGcPDFHF06Nhkyz0uC2QyES2dOa8yDvc5qjlwyc5JCcZeEfNOop9S22L7j0HLVWaeqgycc
Jyut6vcp1Q2t59QPkq8QqKkkDKe0kystNpaRyGVkxevMh3T4WEUIw4YTOuUqChgumOdwEd8e
RCqZMZaIGSkOVl5sUXgi5o3i8JaONjnG/ETMeo7FmpDFCRIxG0wc3VLS6ZuxMBHzwWO5pmRx
RCJmk4njG+EYviPnaND8DZLlSTp8Q/c3WHa/2OEJBnCDJQKFhb4/WuKIJ28PaNHYCi1en9Ai
IWstcW0VgCe60j18ZWg1B+7By6glO4TmegVjBOACjWVk7lhO6anJ0Gky9J26ugjRkwl0a5Lm
uix/pjnswgm02aV1I7rx80C7huixItFlhYdVYqao+quYPyk0VKnUiKp+q25V66o7w0ulBoFq
NvPOS8su152tZyHHrHghnyawz7gF06GnQQGDwALzDPFXwSJx9zqJGvP0UmYFcR+h0mrK1xG8
y+RHRjWH7nvLl4Pur+/SGbqqmQMSuk1G7WZwzvO0Qr85nc9v9orrabNm6L/Nq9GYMrSW31nN
1vls1OES/ShEgLUAHMKbJasyursWegWqPHSbWHEt3q9wzbQ7mxUIT2gmseK8sSJeraBvLXoR
RBJ4ahHB3q1bldd0F5/m3aRvRBiaR3TutP3vU0X2iAbxR0OADj5DjYK680gfaOwVwT+xmQju
ak5tduqmFMG3SPXnDtoUDgTBnDpt2ywIluuCwF4XILuPfVsfAjX8/hZDexqdLeAtQTFdr2/2
oufj1epui9aJZAJrxC/48nU8kU9EHOPwI1JXFHBn+jqilEJNaUCaBPCdRtiqxNAfoRzeY8QX
JiAblLNmKQ2iQ2i0QCM5i55GMUaxMCPuLZdWNGTLlRUN+XJdRUN/uaqiYbxcU2Hoe8sdFQ2Z
4sF7FxzsJVU3QUxC3VApwd0GliDiTryZLDj01P5l37d9mlMUJaCvuBj7rEsbFcxCoRi5nurs
POhDaVamvifBF2RMEcBaTFVfvaZYfu1a+jinFmiRqRk0mPn4qqDx/SiWpt+yaoQjlFMJ5aDR
H3hgPlr1mOubClk/0GoaswHegg7/R4be/XWgsVWs0Z0CqTtLCoJgB81mml6zc5XDVI3WaFO0
qwQQ901uYUyZXIgAtRRrYXDnEDYkhwGlMQqN4CRe+F+Y8/maOS2lNM1hr2PbL+x+jzvaUbOI
iLiUyKrI+PTYF9mY4d+srs7NJ/75D3/92TtgrO+QP3359vsOcfphR19fAdi1bTc8/k/zZb2E
uUt0q7/7j3/8usvG3Q/D4Yfi396t4O4K9clRf3CsmryeitKM6BiPl5ulvrsUhrxTItr9UL/u
/og6cqqL3bGk4cPOCIsGf3rY3dAJ/lU6auncK5obDPhDIrzNxocc80RlQ4jEK+RJ3aXbUHhK
j9RLYDgXKr0BaPcAgvp2PuscAFXszBo/qWv7YTFQACxGbIges5esqgEx0eWkrl4OwlPxBZZ1
Sqk+qstGcWLIDF3Wo2YK5Vzh+Cq6UI2zaWdV+1LmdFKETYkB9kVtArbghMasCUrbBOGHdUaW
nrJrVavWkwm2tAGrNnuAZFTc+soESgkm5nXYlKlm9wkgMmoAfHux5KP2Qy2GYu9etdScS0UU
finrtG3QM9rSpE7N9Iff767D+aL5QvbjEsNUF6DC02QshGRhKREM8gGSoKgVGxMwYCM1bQUE
s2mZaBpbcMAG3dgETehQHVir2P40uDAeUTlCY6svHd814KWsZ7YVSBk1+6gCmeB+FOyEVHUO
mZ+xiUn/1tTOevABoR0RiZPy739P//O/fvnl4D3g1z9++/lvv/32y89ff/kz2ADADP/y268H
7owx7dPwz3/5u4MRbH/SIvsqR5Va1VdVL2HizoWWwgRjEaq4kOsVWGC83CRJfULETEyhuGOR
j8SkHuqkBDSH1r0LiwLCCIGhAdb/s+GtyU1miMhQogg4BmwTnI0NiAzAojI/igmLxvM3M2Qb
Sa4pGaboBAdrGxRp4fi6GgH6k1Kv1MWEeKLHS0qb8MYAef9exzSf7CsddRCBdU5bSamHUeCC
hCH95GRN6lg1IC5JAjIksJYMTLspcTwm6dwyohktFS3/Lqvgl5KOK2OaNGLI8rzssCxWgYip
GS2Dczlqv4yJhVixYGSASgU2HhMPMXgIbOys2nykCWIhViyYGo1UQt4c0/6x2t+Ua8NlGov2
m5qz4XUoR2K6BV/cA1/cU3yZ6u3sznKa1dLRnxuHsingdJgKaEpJyHx37Mv8RU8JmlL8BbrX
vF6zDnBJcMVdIO8XNA3sXuvP6OwrZ/RpUaxVqFJqac6lRD2NF9R/Va4edh3ooydZTNnk/Vtn
QNJzQCl2AgxqBOxjVogH+kygNMYZicUklQb1DX1aB9QHlKlvlR/F52dzhctZuOQW4XaOqBSu
Va5xRMIZwiFqzYmeC7zrUld3kC+n4Up4xK2kjH9FOawg6rUBWIzBIvfgcwUk1b8dTEYAWt+2
CsEmBIAoB9Mq9ZyCSZsTMFM12LHJy0FViLHK4wSnz/QXBSMjN8DhCBIkMU4xZ5g6VMyqsjhY
u57Z1PRMYaAIXqq6MGXoTFDJ4qDuNOS8HlI1yrH2SNC5ijUfwQkGb4Ag4Wkhe6+lVWEW/ku1
oeKcikOrht+xhN6ZBJRtNFM8hGPaNE45zYj5QvIKPko5RlFfSW0D6obCHN8QK+bcqgkW6RzD
DdVi1iOUq0NWkZKlNFoytCUkU6SXWXcx15C6n1yFFO/VgYZ1OhZVrxVH6lBA9TLQlXuRGjkE
SuqxAEQ9wED76knNU4sQwSl08Gg2UADLXj/UpBxljqwtCk5jjtyXJ0Ms8syZT4MpvbyHyBdW
MpoHW1Sy8Ak6idBO0quvD6TvcvGV2EPzR7u+4JwFBSHOybF8j0Kb4VFJk/vkOj5f0kuhnudQ
ccvpaQNXbxtmTRVIS0TOD2lKLEmGdtMZi/sRzUkVZkySwdG6CQr2iYvA01MftIyp+qxqP3ar
+0xOd0ARqgdyJNvIDuTp7Wxbw6jeOsz2irH6VASASYUjfdmlOk/zhfFZj4Wl12vyJtEBYFoO
EwkAyJQqA5vaaE05MAJIS/RqUGw+UyicAKElm1sUGSwo/vJIBoBj/aw2D2yWUjDV8cwJCiDr
XyZa0JmUA4fBfae1MqXOIAiMUKU/S7XLCnbggT+/N/LNeyMjcemKUMlcho4QtdSlcMRIcsdg
ESMJPvZdKRoeFjGCC34Q3PqyVYaMHKkBx4d6Fqlp9dBDWyM1yLXsX8rCI7RZatcZzcjNojGg
GdHNalJokXDROLWhnrxRlW9jwKIq34YBUtWgikU+XyUyumunmEAOrk8TYDqcX0f5DxKCh5Bc
TdOd1UrVCLveh7oWAWlbQNue1bZpWtJU3dXzIJr3ZMzcqRhlh4v3GPdadG/9a9E9KTp0FH9W
40XvSs2x0juqmlQrkAc25sW0PYfEpDcrXNjA7Ug6fO8UoVVvquUYOi6RmfhrNKswQhpHYmUQ
c7hXGELdXnorWwitPhVGtMR0eno4DWRAoQ3pFkR3mZG4fwmlbilUoJvvVzndryI79+YKw8Rt
GvdlOQNNMZS9zpAPUvVQosy9tIjtXzndEPp8qVQ83ds80zWh/hqzanaE7nWWWza+cdu9qk3E
d2qTbLj+NDPkVif9t3TFKOK+8G4YPfcZqs1ijvy3fH7rq7FMj0jy6bt+bTmDiSJ0r12iQiDq
Jo6o9RYU3Fecfkhp7ip5iHAai2OqviDxkNJnaMrwozbSpp9b3aO27dh0AUddCsamAzgqH0UJ
bqr/o1NUGu87alciHHXNQUi6uV7eeSJkTMPF2K1RmeZPmRExaSPwMaWvXA5Yml3GSzXA1M8a
bFIaNi9/t+e0aQ0k1JcyHlLvFc4CPuprpqXyPVp6VEaEgjp9GltRH1M0cWnVAoFqiVDXEsa5
lWRSBBU6tHFwcDOg+W37xcOPi+LJx0nxx/S5aqExkKU6RFCbYSDWYbeVfDH8qI5HsAQcLe3N
6mVD1ZW6vk3NW166ewv5zIqnGVF1EluCZtaPS81hzXHuqq0xziUHkaN3yw6mVpadWFYYdfWp
7c/mGuSbC5IffbpqqtebQ6kLi+nARZBMIqiY0a8Il7RGDaPKWxW3s8KZjdW7EWxp/93aGubF
b3ammzcmKktyrpQDTRI28lSZPClmkwFEXYUCYgwGkD470/caoS1GWpBOOABCSgRs6e7ogNOE
2scq/RI8y2tFTqcP8FP1FmYSCGDK79SFnY7dLbIjskHKFDAynKjAkJ77duoIbrJJpb00qzFr
ulGa9MW7yXObqX1NgqnIj2+WSc+7mdLRhKbMR6iUXm2b0wMqZia+2YbtQVIo2tbUpTsNN5qi
e27vep2wZ/WSLR+jK9PukcgO0gZwSEsV8nbfomuHuWzHkLo4hWCCn1EDvH4pPkgL9CFLw2JD
tyGA401VWmapqauNP1V0Mfxi3MhgmEqHx9C6hujOgcfMAs4GwBUAxxnf1NhXY+QwBBpPeaDy
A4RrshK6L+cR3WpF6L1wwPCDxwnNCLnSW0NO7xSDzZt+jUNvCnnkJ5HYfFSnkejxII+CJLrz
rk4h0StBTo8Xvc2XdQppUCyJJPI3H9dpHM1SlETh5gM7jaRZkkkUbT6x00iapTiJ4s1nds1o
3wxy6TmPBvn7w+lPUlyyJOabL0sV2tmi8STeflut+TJP3bj0nedw/jtJ2LdsXAbOW7bVQwmF
903/bzuE6Fy9Be/o2f/VhhDF8pwz9LY21i+GuIwcxHcUUZINY2n2dl6XinckV04u4eRBsOHk
L2194HSlDHdBltXSOupls8c30/+xd3XPbeNI/l6zf0Uqd09bugxJgJ8qVW3Wyez6Jl8XZ1J3
TyxapGyuJVJDUrKdv/66Gw2SkvUxruThHvo3UympAQENoNFoNBrw6po8hrxbL/7Y0MUiptvZ
n3VdA4V55KCyXmug9X4mnv5IA4stRrMr1rZWpJbXm65IhvWV7g3ZX/dBBUjF36MnzGoGWOPi
YLaJyiovHuBzSLfVKCdqEOvpNb0HVhJ0oUkejsA4UJt0y7FbLqs2r/e6No7APg8O6k9jL7h9
Py7rG0uy6tP0hdvrT9q6pCsk9QoUlgHjiHYHBbrIupF/rtehSO69b9hhxxqCCg4XHTRCbEMw
TiRaj8yfZV3TNiOydit5yplCttoUj8DUydO4zdM+Uw7saaLIJgDJi83VjGiKjDEpNmre07QU
dXj7GLqgNwzA2L2lTa1rTUlQ9qucvbL9jhHXpygcFnvMwq5Q9GPyks/0shm2jYdPh9t6rykY
8RTgKtfAzhMWe3SQaisBtPYt6maVdYnZrUfWJkA7GC/AmY27lQdLtf6TE5Ek1WK/Vz0TB4Wn
4hhbS2fiwID5akJDjMVl/H0wfBQpZIKv/lUuFmXRjmN7+jSzoQ5d69AdJa1sErt2R0mZTWK3
0CippPaFrvUX4DTA3PXgLuhJpByhzav14DiYo2QW26JZJMrpz8SnbDdyXTQJUArQbUyLvgmR
IWbw6npp/NZoyAGFbPFrE0UZkpEGxIoK0tb6qqzxwHZXxcVosrmQgPsjMojM7MXJaLaZOE9j
07NENKGKSDSTBzO186zCATgVoYbDToaoHXU6HDD7yTAan9WG9jzrtoYNq3JAXyoH93DVcpUS
7aQP4rHd7slXiFskNumV05v03jQ0F2mCY7sDDKhQToyOjMyUxjoyS/E+fe8d4DAHa11m6XU7
GJdgDD6u2sGyzFIzi3uzEgpr2F5khQTlWYp3KugPZLKszK1RYNR1ZsWH9NP7t1e/f/QSZ/Ih
DSLHdUDP0CfPSTz4dPX5zZcL0H0fUhUF5Hj8kH64/HzlYsAWf/bgs3f4WL4iLwJURhGTVbqp
EuV6s42uUnv6ZPYiRnoUngkqtye2XfPQhyJaoolfYDVTpXV3C4rQw4BN/JoX7RwUt6aJX6Xb
bLkpTsdbNoVdeqwIuBhM0tD1k6LtfV0Njsx1vQR7wAwlqOwmXcNqgfGW6D+Er0t6BwO/w8oE
31FVNuT+jil9TfMMRvLIikVaYE2SRHfRuy1tIMxDDRhrtk0rJKhTR6ZYCF7QgjKCw2XgRZAk
ds8V8r2uSFTQzui+p7D3BsulvS/a/jwNqHnbGa/0qdJKzNLYlkW0mnR0XbxBThXa66iJgGiG
DCnB8ZXdlMeNjJ8WFzwpLjhVHF6dIZ0NxXnkinTu5nieZ07d+vKASEtgEoYsUpgtMwQzgYFA
LiooEok8jS0VrMrBwAEiLZI2q5nOQAVCmyjPXggOQfcYQ8dT6qj66YYWYLC2Ewd3ICeeXTfU
FBcoEyfsTFGE+gj70KEKKAWriQNy4ZI+B45OOaOyxf76TCH3jj681W7qDqNCep1td99Df5Zp
3ZQ3ZQWj2HepVcbeyGXDXYvOGrBqsDUhqA485bSmjlmDQdLJ9Oz9GzhaxhPhDs6NdZbOKwxu
wLaSWwUopJKAhHF0TKKhjswZKJJogsB3E2xTWlPNJRdHRL/JzdfoWOjN5kkHRtSBJWyioVXx
bBM4g4OpdyqBLqK6lHJszF88DXxOnw752ARhi2HkjeqdRXhoM3YUtbdZXt+PPEVlf5QwdhTZ
s4Sxk6guFh1WsOMc6n1WfbdhN6J7a+QMOizU0DfX9h6CwnsI7mF/QmE60WTzIFt80KNgDNe0
hV5WCnRa8cDOdzRloyl8vUZdHaFqhy+9MqelBghmp4snoOhqPToRsY4N1qFhr9Zk93icNWF7
rL4D+16p/Quz+61mExta48+gnIPXuou82FJTUMnXdFxpAikrc2h8Qh1jFfRrqCCECoKDd6vz
MjUxm0pFs00cwHfDFygnFdu56E4V+hhwdMEApYMCpcIz7cvNtu6r0uYVBPghubjoUhO2AQh8
bEsBoERAl5dLosaEGyaY1T5naXeNrseD/tKevwKJIwNKe9Y6HF3kpT1YpaocpuG8cDE0wOjl
nFwEtgMiPsBBMj8wluC9LY/sEGTFhOQSKTKkDXRMRFsI7KujfbOjDeiuiaNHNduwGJhDLCV2
5R0NDnbA0Uq2BUxd3Abij6EKWC68QOe0j6t6qxVjKOYYfBPbDu9NL9MgNOEoKNZF6yeyQStq
OKf3+e6W5xy7qvWtXkLLLnMQRI3Xv4fpvXOZ7ht2icnl7+Yae61+r8o/TFi/wrcQhmyeM67z
V2jmNx4yyBnu5hy71b6V8+JXkDHoIwqFNdwmeKeLuuibubvWR0gbBoAQnDI4balQdzxTgwfO
27k4t2XnoPId0GfDRdydGbq9sZnc3Ux65xGhPEtNSK/CM0HlzRuaS8p3bGxgWlgCRwqDtWsp
HNHZpIueZOYSkOicgIi9KwcLu7GkwJbf9qTY64uztFPbFuJ+y5sWX82Ki/Tbx08fYccCH768
+wdIP3x4e/kF9gDw4e/vfwPjGD5c/PML6ED48P7jbyDS8OHq08VvSYCffr389VMSUvY3b5Mj
r+SYisndBxVrPEvdZjtXArbZoLTMFAGK1VpGJ22zdLcbt8ZRj602nQgEdl/09wS2fCIQetYV
ARQTVcDRP779acb2qW8deshTT8OzNUOb9zRN2pH4wLnrBNbbgIyQbYA09j8BjU51gRN2MSAn
j7AJQBI7GbgFjcnHfobjXWpvWSjfN1dCbRCRPU239ybc/ty/vxYxqHZ7l2LQ7PYyxUixH2ei
rFIKnlc+XjWM6jXfnzJR7mYa21m95lXGnIyv7aJjTsZb/mbOxWmW0cULjxT9CQ7qTWdZoPj9
kyzAPnSz7E7vY6lUDEvForHYCOPu6lvgJ6RrztNvqHVA6SCzcXCulLLCQtClHsFH5dPoRKdG
tl4XlflZ4OCRbHk7+llfOTrDoHaWtZOhzUOppkn49Ijyxk1i4eSgTGNURGcuTpA6XNZtwbx6
P49XUywzq2hY4XPP7Ql5xFB15gdUTRic5Ge+ygduzL0UGzZ2T+Z37yy2kQ6nTvVGDDDnNDHH
3WzqYAuKAkUd7/wkuyk6OhkxzQowcOZks86XxPzRsfuOHJCaBi1NBRw1fIz+2eGKXBGn2erL
xj7+c2Uzn/EzJABvPrSt4Sr8idOHyzUche4zOMKDkc2aOcJJEp3kyNzOsAxZ/g4FjR+qhfnD
VwKiEzpry7eXzk9wuu7AzGt6BeB5g1w8zJfmfMrE/JugA3vJnxtrr/ef5YObh76R3Zm1175B
juNzstYU+OIstzA4KzC7w3O2WGY4fI684DM4hp3oiQpr601jzN4RT3nRdpaEjOELgsznWYVF
tTGXz5lnsOmBGgyfEZ7QOef5bJv5bveNGbcB+kDiTOxJOcuD4T56zpxc3ZmjQ/wd3aOMnifV
Vm69c2JgKmIO1c8U29XQAv3zpHY1Ytd/ljhk+cBQcFbL2XN65og9Qn9Cz9mKmMdwf4nlE/zn
rrHsB2T+o/Mi8USWn8hI96eFxFbObYqf2e8D47HzA8ZBX5RhI3b3u9aO2XP7dkEXNQ2D3g8w
aMph7p5lFVYZbNysko/1D/CwBROKi/F/tBhuSfCz1ur1prkp0FFvS8YbfDs7l35fBSWf3lZ9
z9YUjsAlPdkDXUCmP7sNgrKGGUuBIz9S1JbcelSYxtAQPzjVwmFIiHau9xZlbot2f4TPVXZX
pPNyzKpHDtrTBT7R/4uc5ts5rZ3fG82rHfVkJd4Xyn5r00dHmFnNmnfQxBwmU9udULg77c+v
zsgVN17vd2bPBbvAbNAXe5J73XK26cV6mc37TvYxvGpcz8fifreLPy1zS8BOPjmKtGW+fsR4
olvu3+Anb8ht6cw/2ok7/GNi30vnnEHMY/QMXwP/kKuP9/0CdKNM+XxfwTlyiFytN92bBl8K
064z2+zvEfrWJooeg8DDxmGbD0RvTDS3zWH7ToGK0XS8cQVywEdy430ikM1RlqWbzVqiwp3q
zBYJqFSfZsb4Qjfsbigm1tZo7PcE3xgbF0FnhWE05s1YoYnCpwXRlzcdDD8genR4Zisj+ypB
SRkVyiYNkIMxY/3RZBTtlsHrdALL/bgzaHkEojcm2qUP6HpMxwUIaP6YhhM20Y4aN2MspJC2
0xnsgdROdErMQLRG4uGCeOxqwd5TBqSI35MbS4zLNw52hMMGHe4JR0ivHgZ7w63o4c394fap
+r3RUmPiMC7huLpR/7tjOndpMK6tX5IhgV6d87lxvL4CeafNZqkEarxHpVUv0RR7onU03Vmy
gO6O8/NA6h2aUZRA9jl4cn+hgiRveADt6diHZortjX3Mw3NcxeA7EPQHWnD8vdnGDw71ytMO
edIXB7rhQA88bejR06NLkibgiozJsqIlx+xHQB/iFw6vsCGW7LtGnzMTjPf6YA2fSVjf4lIG
VdCDV9STnsuVmD8f1B87bssEOMEqzhizw7GmxuAm7WA0Da5BEc+o/gCi96en8+rWBjmyk3ee
buslzrv+sQI+JIGEPlaYT0jmfL7fv+9xOAKsXu0du2oKnCrxbz1kfL/TGSJR2NQ4/S7S6nqv
RLoGT7qBTw/52CcI+fCIdAF8MydHvBQEIY+dCWehK/RINONXL3N7UZTtEVyZ8uElO6zPXL06
ZZHcPml+RJH03HfGAbYT0MMHziY0EZ/J0PRMBhY0zzqOWbRHNXVzl2h8FUN7HmciWm9DVdui
GVlR/R+3IFe+PY9vjOiaM7FomheLbLPs0mX2iEKvPYXlay7/Nm9sij1d7DP6lNGKSPc95VeR
Oa6NJSVP86Ze4ysLGl9Z0F7IL5Uc78Ys3+9HjOXxogOxUHzpiC4jm77Ev6lhr4WZfsOIUkvh
Iy7oGOoXPb55ML7vnK3WFD9OD5oe5vKP6kGn1UNn3lzUXjx+U9bfz7igvydCf9vAGT9RG+xn
7AtU7kzjc6ERUa6Xd/3rUUSwd7r25s7Oe+5UoL1Eo9X4td6dSzQmX//HF/Q4n36Sz/7tBeWP
8z1psf1TEioYPaPrPWlv/+q3VuG4vHA/445AKHpnpkztvX28fM/LE0evaBWMb5VhvD32G9Bd
+0pMmT5wt/aXyMyDHkE03CFb9ZQosrcwmMIybKNekOIPl2CoOtAYXmwfkeLYHBgIekOKKHT9
TJn3IYhA18+UP9GKw+X4Lr6iR03+TSAQCAQCgUAgEAgEAoFAIBAIBAKBQCAQCAQCgUAgEAgE
AoFAIBAIBAKBQCAQCAQCgUAgEAgEAoFAIBAIBAKBQCAQCAQCgUAgEAgEAoFAIBAIBAKBQCAQ
CAQCgUAgEAgEAoFAIBAIBAKBQCAQCAQCgUAgEAgEAoFAIBAIBAKBQCAQCAQCgUAgEAgEAoFA
IBAIBAKBQCAQCAQCgUAgEAgEAoFAIBAIBIL/B3j5qi1W7bIo1mV1k8RuONFB6E2UN+1umyLL
E1fHEx2qYOKGXjRdtEkcu7O/xkE0CXSgMeOiXBZtomMFlDhASlverLL2Ll3W87vE9eJJ4HsR
J8DvPfh95AIxcJhYZcskVh6QYm/iQj3X+NMiN8TQc4gIGf/YFJsiiYNwEkTaFknEtMtKKCRW
yBwmR6bwrE1b+H+d+JMgdr0xrfwORUHWWFM71llTVF1aPBTztMyTEFoYh6Y9xXIxpoeOQ3Vn
S2BzaGXoaKpz+grZnTj4319et1123b581WGHbKqyrpKvcaxnm8iNPSQmru9BztB19BTyQllx
7M+yxpk6U8/R4dSH1MD3VbBb8IvX2RJ67oX3l/94fxEm8L3tGhjEF69+aR/bX5ZltXn4pazm
y01e8Ld2flvkr29f9UwtmqJIodlZCr/dzDtkLZi1rkcJy7LtoGEh1q+nqwz6UOmJGfSDbRyK
65IujsMZlGbzeeOM3+uqGFUZQZWh1/cjdWK9WLRFB6OmaMyo6HV2A5LmMwvL+j6tq3RVrOrm
MfEmIHvRlEq+z+6K9K69z9Y50KFjIYF+m67KCn7vGmk0JCgGSUYWDem2vLlFWjxUja2CgYl5
YOIpNG/ieRpqdaZVtioSz524bqSNTIJkYTUuiQ/xtL7JM+hNx3Fmf4V/3dlDu77BHk6BniWQ
2cgzd03WdNDcPG8Mu85eEgxGRUnKiDQlQU9gQuL5mKCPjxPlhiECPjwYo8jmQUHcyUT82XGC
3GrWeg4mtNgSzZ2hpvDFp2ahJONUvVms0xUJt+3so4xQHYaZYIZ12IyhGuUc99VX6r/WD4Ko
qvMi7RkK7bSZMisaeenzYAmUL7L5fB9zBpRvoh0aS8w97kntOxG1YAvzLU9xTNLrssNkV3uQ
7Ho0OtfEGxQXY0+4DgzwdV13WJQZYcjp02BRFbtDDGlGdEZpdoy1z3Jk0oxsAdHICxFBLblI
MnJCpKp4MOIGdBaSg0OwviH2zAi4Lo6Aa/NF8SjjdrWrKXQImiLQQF6tkjhSZtrCV+K+n7hA
KKq8n7TwlTjToT8xiwVQcNal66YGhlVsBQboi2V20w6TEznYLtPbAqZnl0Q0P93AkpfFwhSL
s3LI3VBmovvBiIO0vYXmmITIVrheN8WWU6A3YKHCdOXZ6us1yo+raIQ1jDDRiibrQK+3tmsm
yrdNX9+AHsO+iCxPuFomLiwi2rXsNJnpIa17Pppym3WFERxsvY6OrywHefhKDLbKg6QKeab5
6QazhcsKdr6sW2qlHalNRTLtuCFljSirGTUcm2KO8uSSdHsOJfJq/1jNIcVzKcWDFDuEVY0j
i2nUY56eLUg3meG8X9tU4s0LONVoXdTe9Qar9IgfD/mxY3uwH9r7NYha1zwaWfZikGXlzFoN
EzfxJ7sd6Kod7YKMfAUBmbWwDu0ve2Qa6SjgziirvHhIrPiSLN1m7a1Ru6bh83pTdQlOW25r
L8mmcctmQzVgc6CO+6yEGn0jifCLqZFDKhXaAB1LisiIx/VmsSiaFqpTViy2ZdNtqJH+sBzg
L9HSiqOJf2ItYFVn+kypGXRC30cwYfbsjOhP2Rmr1djIuCsa0L1p+7hCqVSatEa23BR2UGj5
hBRr9fjxFFuBrTvCc51vlgWWeF0vqVAYuOhpmR71xvGmm2KaYkFlhGj45MU6CX1WZpiCX0wZ
NNJIgrwRiqQKTxlDpvTka+hrlCrU22m9sPPTsom6cFSF5ToY2xFG0DY4yVQ82+hNWwwCxmZL
njDPUyuDe8qzgt4CK91KIMjwGr/yhKJEMJTIOAFjn3UlZcLmWh0JzWcCK8WyQtF1NE1+TZOf
td98WWTVZg0mfGjVX/EAVvr1khc4/BnpBY2atHiYF2tUYZyFZnJitWT/S9SU+Ds7G0DxtcZI
4RJJl+gASuTh5RyJnSz2F1xSP2fmWQX2+bLOiOyenjSm6LJa1Cg6GkUn4KXcGY0c2648EmZQ
+9FTPLA7Nbz89zefP+McA3ULnfHyNVSF1QAJdUJZb1rI8/FTitlsrhc21+RV9mryN9DWN2Ch
tD27acoM81TcYhfARuQKWO9toWDqvYKBQlPdU5MjPxlpgxevu8d18eLlkZyTv9XX/wL2sC3Q
GcfzeeFfjvE30jW7KTPvtX7t/GdXtJ0aFE3Z/JFRf9CYxGCr6tusypdFAyPqk2j77rAA2mEx
g0TWqh2jfh7GPA22ZGIFTr+yGevK90jaYjvJDgrLS2THV7Pi6+WHd1/Sv/8zcSZf//v3d7+/
w8/u5O3lPy7xkze5evfl8s17/KwmXy6vLj59iPCLnlx9fncBKZf/g1/9yZvfv3z68gY/B5N3
V5/xQzi5uriiYqLJ5YcP795evvlK5ceTi/+9eP/m7bsrqs2ZXHzwnIA+u5P/MkRv8uHNxVC5
qyaXV5dQO33Rk4Otur0H8e+KptmswXwHSaBWksnxf5VZWW/bRhB+pn+FkLpAC8gOl+dShYHG
aS40TVFbBfpQQKAk0lYriwoPO/n3nW/24Iqi1dZP4u7sXDvHN2t8WQ+qdEB2dgAXMecnNdoy
0o5v7rt2XT0BpMTc6WMXeRCjJQAT7ZnL2DT9kr4OTM3qW92Dym18azBRtIu8LFGsvmKDQUyi
QMwpSAEj68+LVUXFqNoikKhJJgDJcWTokTJuCC7WRbNS7TQJiDIJ4RPabzsUXNavD8skYlWE
doaOX0SWdgCV4PZ+Fmnj7Yw8nKricKDFat9BplYkhiIJFFngvSLfartQh7ROZmN5b9cHvTM4
iuokvSref1jc/vp2/uHmN4rrT2/mi/kfdkHwwk2/EEznr25//kiLZiUcD6+mKluoCBs4tBIJ
7eGfx2KW6BTmpKWPE03eMOorQ0KVQVpHp1wXUqcuWNB9gisebraFOxunAWZjXRdS7mtpH/1t
3w361q2fzzqCz1lqugFLj09Ozez6NKKCYnw5R7Lfvn7/5ifUloPVm98/0TWcNOIe73xgGcPF
Cv76aTh9vqRRQjRPfATAy6fPRZ/iKWdxSlls8x8EGimknHtS5Z7xyI6SRu9LRhIycGoA9oEm
kC+SPSsjZ/7A9r5rAY8kVxepphyLxdU2cItk1aQqMLpWMPeubqqatTMlg21aIetxjpXOfGcE
wf7yoXpEIcpY50zprKETn3/atCtA+Iy1ziI+L61ay22+Q+HKWO0sYfQUWK1KKjs02oGA9c6k
C6/Av8ALAl1hy1pASRrfmUhGh0asiy2/TmSxgVSGQUUT8mbHShpQxVv5Y4GzBY+PUhj4xHp3
m+16kbctuYxGQhZLxqeRxVJ839SsAZjvONEINDKdujkNrrR+JGOxrxoQxUxEnohp3opTq+ld
0X75CoKUCcgT1Kt9eTJCK0IUq4c1zSSoIGQgUJpqTIka7tQoJ3ScVYw/G7zkjSCzAWdwFJgu
owOOT/UGl0F/0FO4Yaye0wW/HgjBsWDhxWbFh9h6DOmBsCUAwyEBIxjPk7ngydxEb7dTQQSU
3Tc75KHgUV0EbtAqyCM5RkWizafPlB9SVtie2QhVtUwEyhLfROaoU6h55PVd/6ZLx6geRr5P
0yp4hObdNPtBIWT/mdFufAyY85DQyM2u2bmjk/4eKdTe5d22Wm49Cy33ef2weMzrY1Bsdmbv
SFHzpil8hsP8npkdTMFHuNecfx7xWgohzo7FOijXrF1tXkAOWXggWJlUVpVVgn5Pf0QHgcvO
6GtGU/ovQvHMl7tJogD9FKv9+JJvdi+X3d3lilzGNvpEAHEwlFzOMpibd1nWFN/eebMHUSg8
75sJadhcTfzphJIbP17ST7p+tUZc6px+0VG0Z8//4us/dmN5vEi6BUONQ2hMNv/lkUxWas1K
nX8sC2Ueuxj289IFNu3/IUjztyKj+0uU9epks6r2hT+zZHoftqutC+XaGj348N0jc2/p1Z+7
F4fbwnf3KSPvhwTCJVgX5PzJt+vJMaPApbs+3g/d/ddq/5k4QUPVwWbjxVlz4sZZ5fgJh7eR
4DbC/xE/ruwD7m48UbMZD6i4DyiqWyMRJX2/5OC5kM+F1PU1XNl0y45lKXm08OSdi5RK3He0
8j2MjYbGZjA2OvO2GyaFhqSiYS9KHIpHPRRr/iifln8yyj8h/jmT7uku279BmY4yTTVTQkuJ
ZSpHmUrNNJvWxeeOhmOgfJBno5wzxTmk3u4rzkpSMg0iI0lEUqqa4g940DFeVjKjKbKE8jXf
MkeyjE8NS1GoSpFQoqi4aps8QClmI1LFMeas5Z/plHOMn0Vab1fVRVWvi9p+P+SEcVzZmeFH
dppjmoh/Gwas4rD2hFx7ROAYRvpiKRw3JjTSyHPnAVNG4zyj/26CNExj+kj+zYZhPIYRy6OA
XO60YkhRus2M6W1Q/gNDEaX5AFABAA==

--WYTEVAkct0FjGQmd--
